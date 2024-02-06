import 'package:auto_route/auto_route.dart';
import 'package:scheduling_local_notifications_app/router/router.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthProvider appState;

  AuthGuard(this.appState);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (appState.isLoggedIn) {
      resolver.next(true);
    } else {
      resolver.redirect(const AuthRoute());
    }
  }
}
