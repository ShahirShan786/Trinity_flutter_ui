import 'dart:convert';
import 'dart:isolate';

import 'package:ui_machine_task/core/model/models/notification_model.dart';

class ParseWorker {
  Isolate? _isolate;
  late ReceivePort _receivePort;
  SendPort? _isolateSendPort;

  Future<void> start()async{
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(isolateEntryPoint, _receivePort.sendPort);
    _isolateSendPort = await _receivePort.first as SendPort;

  }

  Future<List<NotificationModel>> parse(String jsonString)async{
    if(_isolateSendPort == null) throw Exception('Worker not started');

    final responsePort = ReceivePort();
    _isolateSendPort!.send([jsonString , responsePort.sendPort]);
    final message = await responsePort.first;
    responsePort.close();

    if(message is Map && message.containsKey('error')){
      throw Exception(message['error']);
    }

    final List rawList = message['success'] as List;

    return rawList
           .map((e)=> NotificationModel.fromJson(Map<String, dynamic>.from(e as Map)))
           .toList();

  }

  void dispose(){
    _receivePort.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _isolateSendPort = null;
  }
}


void isolateEntryPoint(SendPort mainSendPort) async {
  final port = ReceivePort();

  mainSendPort.send(port.sendPort);

  await for (final message in port) {
    try {
      final jsonString = message[0] as String;
      final SendPort replyPort = message[1] as SendPort;

      // Decode into Map, not List
      final Map<String, dynamic> decoded = json.decode(jsonString);

      // Extract the "data" list
      final List parsed = decoded['data'] as List;

      final List<Map<String, dynamic>> simpleList =
          parsed.map((e) => Map<String, dynamic>.from(e as Map)).toList();

      replyPort.send({'success': simpleList});
    } catch (e, st) {
      final SendPort replyPort = message[1] as SendPort;
      replyPort.send({'error': e.toString(), 'stack': st.toString()});
    }
  }
}


