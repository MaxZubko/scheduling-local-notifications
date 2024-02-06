import 'package:auto_route/auto_route.dart';
import 'package:scheduling_local_notifications_app/features/auth_screen/view/auth_screen.dart';
import 'package:scheduling_local_notifications_app/features/main_screen/view/main_screen.dart';
import 'package:scheduling_local_notifications_app/router/guard/auth_guard.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider appState;

  AppRouter(this.appState);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          guards: [
            AuthGuard(appState),
          ],
        ),
        AutoRoute(path: '/login', page: AuthRoute.page),
      ];
}
