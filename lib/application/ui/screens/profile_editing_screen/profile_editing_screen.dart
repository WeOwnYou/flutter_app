import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_vm.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';
import 'package:flutter_app/core/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ProfileEditingScreen extends StatelessWidget {
  const ProfileEditingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.read<BottomNavBarVm>().userInfo;
    final emailController = TextEditingController(text: userInfo.email);
    final phoneNumberController =
        TextEditingController(text: userInfo.phoneNumber);
    final userNameController = TextEditingController(text: userInfo.userName);
    final isLoading =
        context.select<BottomNavBarVm, bool>((vm) => vm.isLoading);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                enabled: !isLoading,
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextField(
                enabled: !isLoading,
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('Phone number'),
                ),
              ),
              TextField(
                enabled: !isLoading,
                controller: userNameController,
                decoration: const InputDecoration(
                  label: Text('Username'),
                ),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: LoadingWidget(
                size: 100,
                color: Colors.blueAccent,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: isLoading ? null : () async {
          await context.read<BottomNavBarVm>().changeUserInfo(
                UserPersonalInfo(
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text,
                  userName: userNameController.text,
                ),
              );
          unawaited(context.router.pop());
        },
      ),
    );
  }
}
