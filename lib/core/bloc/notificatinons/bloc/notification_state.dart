import 'package:equatable/equatable.dart';
import 'package:ui_machine_task/core/model/models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class NotificationFailure extends NotificationState {
  final String message;
  const NotificationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
