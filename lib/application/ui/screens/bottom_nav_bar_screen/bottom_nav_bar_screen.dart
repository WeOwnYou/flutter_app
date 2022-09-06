import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/router.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_vm.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatelessWidget implements AutoRouteWrapper {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        MockRoute1(),
        MockRoute2(),
        ProfileRouter(),
      ],
      bottomNavigationBuilder: (ctx, tabsRouter) {
        return BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blueAccent,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '2', icon: Icon(Icons.two_k)),
            BottomNavigationBarItem(label: '3', icon: Icon(Icons.three_k)),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.perm_contact_cal),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: BottomNavBarVm.new,
      child: this,
    );
  }
}
