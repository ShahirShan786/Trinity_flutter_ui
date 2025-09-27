import 'package:bloc/bloc.dart';
import 'package:ui_machine_task/core/bloc/notificatinons/bloc/notification_event.dart';
import 'package:ui_machine_task/core/bloc/notificatinons/bloc/notification_state.dart';
import 'package:ui_machine_task/core/controller/notification_services.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationServices _services;
  NotificationBloc(this._services) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      emit(NotificationLoading());
      final result = await _services.loadNotifications();
      result.fold(
        (error) => emit(NotificationFailure(error)),
        (data) => emit(NotificationLoaded(data)),
      );
    });
  }
}
