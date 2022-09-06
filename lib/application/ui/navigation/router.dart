import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/auth_screen/auth_view.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view.dart';
import 'package:flutter_app/application/ui/screens/intro_screen/intro_view.dart';
import 'package:flutter_app/application/ui/screens/loosing_screen/loosing_screen.dart';
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
    AutoRoute<void>(path: Routes.introScreen, page: IntroView, initial: true),
    AutoRoute<void>(path: Routes.loosingScreen, page: LoosingScreen),
    AutoRoute<void>(path: Routes.authScreen, page: AuthView),
    AutoRoute<void>(
      path: Routes.mainScreen,
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
                initial: true,),
            AutoRoute<void>(
              page: ProfileEditingView,
              path: Routes.profileEditingScreen,
            ),
          ],
        ),
      ],
    ),
  ],
)

class AppRouter extends _$AppRouter {
  AppRouter._();
  static final AppRouter _appRouter = AppRouter._();
  static AppRouter get instance => _appRouter;
  // factory AppRouter.instance() => _appRouter;
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
