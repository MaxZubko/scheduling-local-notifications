// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddNewNotifyRoute.name: (routeData) {
      final args = routeData.argsAs<AddNewNotifyRouteArgs>(
          orElse: () => const AddNewNotifyRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNewNotifyScreen(
          key: args.key,
          recurring: args.recurring,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    RecurringNotifyRoute.name: (routeData) {
      final args = routeData.argsAs<RecurringNotifyRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecurringNotifyScreen(
          key: args.key,
          recurring: args.recurring,
        ),
      );
    },
  };
}

/// generated route for
/// [AddNewNotifyScreen]
class AddNewNotifyRoute extends PageRouteInfo<AddNewNotifyRouteArgs> {
  AddNewNotifyRoute({
    Key? key,
    int? recurring,
    List<PageRouteInfo>? children,
  }) : super(
          AddNewNotifyRoute.name,
          args: AddNewNotifyRouteArgs(
            key: key,
            recurring: recurring,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewNotifyRoute';

  static const PageInfo<AddNewNotifyRouteArgs> page =
      PageInfo<AddNewNotifyRouteArgs>(name);
}

class AddNewNotifyRouteArgs {
  const AddNewNotifyRouteArgs({
    this.key,
    this.recurring,
  });

  final Key? key;

  final int? recurring;

  @override
  String toString() {
    return 'AddNewNotifyRouteArgs{key: $key, recurring: $recurring}';
  }
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecurringNotifyScreen]
class RecurringNotifyRoute extends PageRouteInfo<RecurringNotifyRouteArgs> {
  RecurringNotifyRoute({
    Key? key,
    required int recurring,
    List<PageRouteInfo>? children,
  }) : super(
          RecurringNotifyRoute.name,
          args: RecurringNotifyRouteArgs(
            key: key,
            recurring: recurring,
          ),
          initialChildren: children,
        );

  static const String name = 'RecurringNotifyRoute';

  static const PageInfo<RecurringNotifyRouteArgs> page =
      PageInfo<RecurringNotifyRouteArgs>(name);
}

class RecurringNotifyRouteArgs {
  const RecurringNotifyRouteArgs({
    this.key,
    required this.recurring,
  });

  final Key? key;

  final int recurring;

  @override
  String toString() {
    return 'RecurringNotifyRouteArgs{key: $key, recurring: $recurring}';
  }
}
