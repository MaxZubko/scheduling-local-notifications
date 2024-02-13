import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/features/auth_screen/view/auth_screen.dart';
import 'package:scheduling_local_notifications_app/features/main_screen/view/main_screen.dart';
import 'package:scheduling_local_notifications_app/router/guard/auth_guard.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';

import '../features/add_new_notify_screen/add_new_notify.dart';
import '../features/edit_notify_screen/edit_notify.dart';
import '../features/recurring_notify_screen/recurring_notify.dart';
import '../features/trigger_screen/trigger.dart';
import '../models/models.dart';

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
        AutoRoute(path: '/add-new-notify', page: AddNewNotifyRoute.page),
        AutoRoute(path: '/recurring-notify', page: RecurringNotifyRoute.page),
        AutoRoute(path: '/edit-notify', page: EditNotifyRoute.page),
        AutoRoute(path: '/trigger-list', page: TriggerRoute.page),
        AutoRoute(path: '/login', page: AuthRoute.page),
      ];
}
