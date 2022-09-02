import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/auth_screen/auth_view.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view.dart';
import 'package:flutter_app/application/ui/screens/intro_screen/intro_view.dart';
import 'package:flutter_app/application/ui/screens/loosing_screen/loosing_screen.dart';
import 'package:flutter_app/application/ui/screens/profile_editing_screen/profile_editing_screen.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';
part 'main_navigation.gr.dart';

abstract class Routes {
  static const authScreen = 'auth_screen';
  static const introScreen = 'intro_screen';
  static const mainScreen = 'main_screen';
  static const loosingScreen = 'loosing_screen';
  static const profileViewScreen = 'profile_view_screen';
  static const profileEditingScreen = 'profile_editing_screen';
}

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute<Widget>(path: Routes.introScreen, page: IntroView, initial: true),
    AutoRoute<Widget>(path: Routes.loosingScreen, page: LoosingScreen),
    AutoRoute<Widget>(path: Routes.authScreen, page: AuthView),
    AutoRoute<Widget>(
      path: Routes.mainScreen,
      page: BottomNavBarScreen,
      children: [
        AutoRoute<Widget>(page: HomeView),
        AutoRoute<Widget>(page: MockView1),
        AutoRoute<Widget>(page: MockView2),
        AutoRoute<Widget>(
          page: EmptyRouterPage,
          children: [
            AutoRoute<Widget>(
                page: ProfileView,
                initial: true,
                path: Routes.profileViewScreen,),
            AutoRoute<Widget>(
              page: ProfileEditingScreen,
              path: Routes.profileEditingScreen,
            ),
          ],
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}

class EmptyRouterPage extends StatelessWidget {
  const EmptyRouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
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
