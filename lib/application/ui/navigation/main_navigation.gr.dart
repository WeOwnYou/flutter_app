// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'main_navigation.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    IntroViewRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const IntroView());
    },
    LoosingScreenRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const LoosingScreen());
    },
    AuthViewRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: WrappedRoute(child: const AuthView()));
    },
    BottomNavBarScreenRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData,
          child: WrappedRoute(child: const BottomNavBarScreen()));
    },
    HomeViewRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: WrappedRoute(child: const HomeView()));
    },
    MockView1Route.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const MockView1());
    },
    MockView2Route.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const MockView2());
    },
    EmptyRouterPageRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    ProfileViewRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const ProfileView());
    },
    ProfileEditingScreenRoute.name: (routeData) {
      return MaterialPageX<Widget>(
          routeData: routeData, child: const ProfileEditingScreen());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'intro_screen', fullMatch: true),
        RouteConfig(IntroViewRoute.name, path: 'intro_screen'),
        RouteConfig(LoosingScreenRoute.name, path: 'loosing_screen'),
        RouteConfig(AuthViewRoute.name, path: 'auth_screen'),
        RouteConfig(BottomNavBarScreenRoute.name,
            path: 'main_screen',
            children: [
              RouteConfig(HomeViewRoute.name,
                  path: 'home-view', parent: BottomNavBarScreenRoute.name),
              RouteConfig(MockView1Route.name,
                  path: 'mock-view1', parent: BottomNavBarScreenRoute.name),
              RouteConfig(MockView2Route.name,
                  path: 'mock-view2', parent: BottomNavBarScreenRoute.name),
              RouteConfig(EmptyRouterPageRoute.name,
                  path: 'empty-router-page',
                  parent: BottomNavBarScreenRoute.name,
                  children: [
                    RouteConfig('#redirect',
                        path: '',
                        parent: EmptyRouterPageRoute.name,
                        redirectTo: 'profile_view_screen',
                        fullMatch: true),
                    RouteConfig(ProfileViewRoute.name,
                        path: 'profile_view_screen',
                        parent: EmptyRouterPageRoute.name),
                    RouteConfig(ProfileEditingScreenRoute.name,
                        path: 'profile_editing_screen',
                        parent: EmptyRouterPageRoute.name)
                  ])
            ])
      ];
}

/// generated route for
/// [IntroView]
class IntroViewRoute extends PageRouteInfo<void> {
  const IntroViewRoute() : super(IntroViewRoute.name, path: 'intro_screen');

  static const String name = 'IntroViewRoute';
}

/// generated route for
/// [LoosingScreen]
class LoosingScreenRoute extends PageRouteInfo<void> {
  const LoosingScreenRoute()
      : super(LoosingScreenRoute.name, path: 'loosing_screen');

  static const String name = 'LoosingScreenRoute';
}

/// generated route for
/// [AuthView]
class AuthViewRoute extends PageRouteInfo<void> {
  const AuthViewRoute() : super(AuthViewRoute.name, path: 'auth_screen');

  static const String name = 'AuthViewRoute';
}

/// generated route for
/// [BottomNavBarScreen]
class BottomNavBarScreenRoute extends PageRouteInfo<void> {
  const BottomNavBarScreenRoute({List<PageRouteInfo>? children})
      : super(BottomNavBarScreenRoute.name,
            path: 'main_screen', initialChildren: children);

  static const String name = 'BottomNavBarScreenRoute';
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute() : super(HomeViewRoute.name, path: 'home-view');

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [MockView1]
class MockView1Route extends PageRouteInfo<void> {
  const MockView1Route() : super(MockView1Route.name, path: 'mock-view1');

  static const String name = 'MockView1Route';
}

/// generated route for
/// [MockView2]
class MockView2Route extends PageRouteInfo<void> {
  const MockView2Route() : super(MockView2Route.name, path: 'mock-view2');

  static const String name = 'MockView2Route';
}

/// generated route for
/// [EmptyRouterPage]
class EmptyRouterPageRoute extends PageRouteInfo<void> {
  const EmptyRouterPageRoute({List<PageRouteInfo>? children})
      : super(EmptyRouterPageRoute.name,
            path: 'empty-router-page', initialChildren: children);

  static const String name = 'EmptyRouterPageRoute';
}

/// generated route for
/// [ProfileView]
class ProfileViewRoute extends PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(ProfileViewRoute.name, path: 'profile_view_screen');

  static const String name = 'ProfileViewRoute';
}

/// generated route for
/// [ProfileEditingScreen]
class ProfileEditingScreenRoute extends PageRouteInfo<void> {
  const ProfileEditingScreenRoute()
      : super(ProfileEditingScreenRoute.name, path: 'profile_editing_screen');

  static const String name = 'ProfileEditingScreenRoute';
}
