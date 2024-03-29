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
    EditNotifyRoute.name: (routeData) {
      final args = routeData.argsAs<EditNotifyRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditNotifyScreen(
          key: args.key,
          recurring: args.recurring,
          notify: args.notify,
        ),
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
    TriggerRoute.name: (routeData) {
      final args = routeData.argsAs<TriggerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TriggerScreen(
          key: args.key,
          title: args.title,
          trigger: args.trigger,
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
/// [EditNotifyScreen]
class EditNotifyRoute extends PageRouteInfo<EditNotifyRouteArgs> {
  EditNotifyRoute({
    Key? key,
    int? recurring,
    required NotifyModel notify,
    List<PageRouteInfo>? children,
  }) : super(
          EditNotifyRoute.name,
          args: EditNotifyRouteArgs(
            key: key,
            recurring: recurring,
            notify: notify,
          ),
          initialChildren: children,
        );

  static const String name = 'EditNotifyRoute';

  static const PageInfo<EditNotifyRouteArgs> page =
      PageInfo<EditNotifyRouteArgs>(name);
}

class EditNotifyRouteArgs {
  const EditNotifyRouteArgs({
    this.key,
    this.recurring,
    required this.notify,
  });

  final Key? key;

  final int? recurring;

  final NotifyModel notify;

  @override
  String toString() {
    return 'EditNotifyRouteArgs{key: $key, recurring: $recurring, notify: $notify}';
  }
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

/// generated route for
/// [TriggerScreen]
class TriggerRoute extends PageRouteInfo<TriggerRouteArgs> {
  TriggerRoute({
    Key? key,
    required String title,
    required int trigger,
    List<PageRouteInfo>? children,
  }) : super(
          TriggerRoute.name,
          args: TriggerRouteArgs(
            key: key,
            title: title,
            trigger: trigger,
          ),
          initialChildren: children,
        );

  static const String name = 'TriggerRoute';

  static const PageInfo<TriggerRouteArgs> page =
      PageInfo<TriggerRouteArgs>(name);
}

class TriggerRouteArgs {
  const TriggerRouteArgs({
    this.key,
    required this.title,
    required this.trigger,
  });

  final Key? key;

  final String title;

  final int trigger;

  @override
  String toString() {
    return 'TriggerRouteArgs{key: $key, title: $title, trigger: $trigger}';
  }
}
