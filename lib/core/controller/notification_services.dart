import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ui_machine_task/core/model/models/notification_model.dart';
import 'package:ui_machine_task/core/model/services/parse_worker.dart';

class NotificationServices {
  Future<Either<String, List<NotificationModel>>> loadNotifications() async {
    final client = http.Client();
    final worker = ParseWorker();

    try {
      const notificationUrl =
          "https://raw.githubusercontent.com/sayanp23/test-api/main/test-notifications.json";

      final response = await client.get(Uri.parse(notificationUrl));
      if (response.statusCode != 200) {
        return Left("Failed to fetch notifications: ${response.statusCode}");
      }

      final jsonString = response.body;

      await worker.start();
      final notifications = await worker.parse(jsonString);

      return Right(notifications);
    } catch (e) {
      return Left("Error: $e");
    } finally {
      worker.dispose();
      client.close();
    }
  }
}
