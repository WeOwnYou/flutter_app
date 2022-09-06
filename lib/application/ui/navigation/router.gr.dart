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
    IntroRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const IntroView());
    },
    LoosingRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const LoosingScreen());
    },
    AuthRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: WrappedRoute(child: const AuthView()));
    },
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
              child:
                  ProfileEditingView(key: args.key, userInfo: args.userInfo)));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'intro_screen', fullMatch: true),
        RouteConfig(IntroRoute.name, path: 'intro_screen'),
        RouteConfig(LoosingRoute.name, path: 'loosing_screen'),
        RouteConfig(AuthRoute.name, path: 'auth_screen'),
        RouteConfig(BottomNavBarRoute.name, path: 'main_screen', children: [
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
                    path: 'profile_editing_screen', parent: ProfileRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [IntroView]
class IntroRoute extends PageRouteInfo<void> {
  const IntroRoute() : super(IntroRoute.name, path: 'intro_screen');

  static const String name = 'IntroRoute';
}

/// generated route for
/// [LoosingScreen]
class LoosingRoute extends PageRouteInfo<void> {
  const LoosingRoute() : super(LoosingRoute.name, path: 'loosing_screen');

  static const String name = 'LoosingRoute';
}

/// generated route for
/// [AuthView]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute() : super(AuthRoute.name, path: 'auth_screen');

  static const String name = 'AuthRoute';
}

/// generated route for
/// [BottomNavBarScreen]
class BottomNavBarRoute extends PageRouteInfo<void> {
  const BottomNavBarRoute({List<PageRouteInfo>? children})
      : super(BottomNavBarRoute.name,
            path: 'main_screen', initialChildren: children);

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
  ProfileEditingRoute({Key? key, required UserPersonalInfo userInfo})
      : super(ProfileEditingRoute.name,
            path: 'profile_editing_screen',
            args: ProfileEditingRouteArgs(key: key, userInfo: userInfo));

  static const String name = 'ProfileEditingRoute';
}

class ProfileEditingRouteArgs {
  const ProfileEditingRouteArgs({this.key, required this.userInfo});

  final Key? key;

  final UserPersonalInfo userInfo;

  @override
  String toString() {
    return 'ProfileEditingRouteArgs{key: $key, userInfo: $userInfo}';
  }
}
