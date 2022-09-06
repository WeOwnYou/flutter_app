// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    BottomNavBarRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData,
          child: WrappedRoute(child: const BottomNavBarScreen()));
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: WrappedRoute(child: const HomeView()));
    },
    MockRoute1.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const MockView1());
    },
    MockRoute2.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const MockView2());
    },
    ProfileRouter.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    ProfileRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const ProfileView());
    },
    ProfileEditingRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileEditingRouteArgs>();
      return MaterialPageX<void>(
          routeData: routeData,
          child: WrappedRoute(
              child: ProfileEditingView(
                  key: args.key, userInfo: args.userInfo, id: args.id)));
    },
    ProfileEditingDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileEditingDetailsRouteArgs>(
          orElse: () =>
              ProfileEditingDetailsRouteArgs(id: pathParams.optInt('id')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ProfileEditingDetailsView(key: args.key, id: args.id));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/main', fullMatch: true),
        RouteConfig(BottomNavBarRoute.name, path: '/main', children: [
          RouteConfig(HomeRoute.name, path: '', parent: BottomNavBarRoute.name),
          RouteConfig(MockRoute1.name,
              path: 'mock-view1', parent: BottomNavBarRoute.name),
          RouteConfig(MockRoute2.name,
              path: 'mock-view2', parent: BottomNavBarRoute.name),
          RouteConfig(ProfileRouter.name,
              path: 'profile_view_screen',
              parent: BottomNavBarRoute.name,
              children: [
                RouteConfig(ProfileRoute.name,
                    path: '', parent: ProfileRouter.name),
                RouteConfig(ProfileEditingRoute.name,
                    path: 'profile_editing_screen/:id',
                    parent: ProfileRouter.name),
                RouteConfig(ProfileEditingDetailsRoute.name,
                    path: 'details/:id', parent: ProfileRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [BottomNavBarScreen]
class BottomNavBarRoute extends PageRouteInfo<void> {
  const BottomNavBarRoute({List<PageRouteInfo>? children})
      : super(BottomNavBarRoute.name, path: '/main', initialChildren: children);

  static const String name = 'BottomNavBarRoute';
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [MockView1]
class MockRoute1 extends PageRouteInfo<void> {
  const MockRoute1() : super(MockRoute1.name, path: 'mock-view1');

  static const String name = 'MockRoute1';
}

/// generated route for
/// [MockView2]
class MockRoute2 extends PageRouteInfo<void> {
  const MockRoute2() : super(MockRoute2.name, path: 'mock-view2');

  static const String name = 'MockRoute2';
}

/// generated route for
/// [EmptyRouterPage]
class ProfileRouter extends PageRouteInfo<void> {
  const ProfileRouter({List<PageRouteInfo>? children})
      : super(ProfileRouter.name,
            path: 'profile_view_screen', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [ProfileEditingView]
class ProfileEditingRoute extends PageRouteInfo<ProfileEditingRouteArgs> {
  ProfileEditingRoute({Key? key, required UserPersonalInfo userInfo, int? id})
      : super(ProfileEditingRoute.name,
            path: 'profile_editing_screen/:id',
            args: ProfileEditingRouteArgs(key: key, userInfo: userInfo, id: id),
            rawPathParams: {'id': id});

  static const String name = 'ProfileEditingRoute';
}

class ProfileEditingRouteArgs {
  const ProfileEditingRouteArgs({this.key, required this.userInfo, this.id});

  final Key? key;

  final UserPersonalInfo userInfo;

  final int? id;

  @override
  String toString() {
    return 'ProfileEditingRouteArgs{key: $key, userInfo: $userInfo, id: $id}';
  }
}

/// generated route for
/// [ProfileEditingDetailsView]
class ProfileEditingDetailsRoute
    extends PageRouteInfo<ProfileEditingDetailsRouteArgs> {
  ProfileEditingDetailsRoute({Key? key, int? id})
      : super(ProfileEditingDetailsRoute.name,
            path: 'details/:id',
            args: ProfileEditingDetailsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'ProfileEditingDetailsRoute';
}

class ProfileEditingDetailsRouteArgs {
  const ProfileEditingDetailsRouteArgs({this.key, this.id});

  final Key? key;

  final int? id;

  @override
  String toString() {
    return 'ProfileEditingDetailsRouteArgs{key: $key, id: $id}';
  }
}
