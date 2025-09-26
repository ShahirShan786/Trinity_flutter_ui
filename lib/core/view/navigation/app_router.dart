
import 'package:go_router/go_router.dart';
import 'package:ui_machine_task/core/view/pages/home/home_screen.dart';
import 'package:ui_machine_task/core/view/pages/utils/widget_helper.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder:
            (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
      ),
    ],
  );
}
