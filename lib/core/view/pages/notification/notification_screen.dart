import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ui_machine_task/core/bloc/notificatinons/bloc/notification_bloc.dart';
import 'package:ui_machine_task/core/bloc/notificatinons/bloc/notification_event.dart';
import 'package:ui_machine_task/core/bloc/notificatinons/bloc/notification_state.dart';
import 'package:ui_machine_task/core/controller/notification_services.dart';
import 'package:ui_machine_task/core/view/pages/utils/image_url_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              NotificationBloc(NotificationServices())
                ..add(LoadNotifications()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,

          elevation: 0, // remove default shadow

          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 2.h,
                backgroundColor: Color(0xFF2FDF84),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 15.w,
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          title: const Text(
            "Notifications",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: const Color(0xFFD2D2D2), // #D2D2D2
              height: 1.0,
            ),
          ),
        ),

        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.greenAccent),
              );
            } else if (state is NotificationFailure) {
              return Center(child: Text(state.message));
            } else if (state is NotificationLoaded) {
              final notification = state.notifications;
              return ListView.builder(
                itemCount: notification.length,
                itemBuilder: (context, index) {
                  final data = notification[index];
                  final random = NotificationImage.getRandomImage();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      constraints: BoxConstraints(minHeight: 80.h),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFD2D2D2)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15.w,
                        children: [
                          Image.network(
                            random,
                            width: 27.w,
                            height: 27.h,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.notifications_none,
                                  size: 30,
                                ),
                          ),

                          Column(
                            spacing: 5.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 280.w,
                                child: Text(
                                  data.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 285.w,
                                child: Text(
                                  data.body,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              Text(timeago.format(data.timestamp)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
