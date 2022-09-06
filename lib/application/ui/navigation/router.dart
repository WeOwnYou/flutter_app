import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view.dart';
import 'package:flutter_app/application/ui/screens/profile_editing_screen/profile_editing_details_view.dart';
import 'package:flutter_app/application/ui/screens/profile_editing_screen/profile_editing_view.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';
part 'router.gr.dart';

abstract class Routes {
  static const authScreen = 'auth_screen';
  static const introScreen = 'intro_screen';
  static const mainScreen = 'main_screen';
  static const loosingScreen = 'loosing_screen';
  static const profileViewScreen = 'profile_view_screen';
  static const profileEditingScreen = 'profile_editing_screen';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page|View|Screen,Route',
  routes: <AutoRoute>[
    // AutoRoute<void>(path: Routes.introScreen, page: IntroView, initial: true),
    // AutoRoute<void>(path: Routes.loosingScreen, page: LoosingScreen),
    // AutoRoute<void>(path: Routes.authScreen, page: AuthView),
    AutoRoute<void>(
      initial: true,
      path: '/main',
      page: BottomNavBarScreen,
      children: [
        AutoRoute<void>(page: HomeView, initial: true),
        AutoRoute<void>(page: MockView1),
        AutoRoute<void>(page: MockView2),
        AutoRoute<void>(
          page: EmptyRouterPage,
          name: 'ProfileRouter',
          path: Routes.profileViewScreen,
          children: [
            AutoRoute<void>(
              page: ProfileView,
              initial: true,
            ),
            AutoRoute<void>(
              page: ProfileEditingView,
              path: '${Routes.profileEditingScreen}/:id', // 13
            ),
            AutoRoute<dynamic>(
                page: ProfileEditingDetailsView, path: 'details/:id', // 14
            )
          ],
        ),
      ],
    ),
  ],
)

/// Main point of the application navigation
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  AppRouter._();

  /// Singleton instance of [AppRouter]
  factory AppRouter.instance() => _router;
}

class MockView1 extends StatelessWidget {
  const MockView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('2'),
    );
  }
}

class MockView2 extends StatelessWidget {
  const MockView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('3'),
    );
  }
}
