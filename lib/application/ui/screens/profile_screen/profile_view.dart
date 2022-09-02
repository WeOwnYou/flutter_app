import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_vm.dart';
import 'package:provider/provider.dart';

class UserPersonalInfo {
  final String email;
  final String? userName;
  final String? phoneNumber;

  UserPersonalInfo({required this.email, this.userName, this.phoneNumber});

  UserPersonalInfo copyWith({
    final String? email,
    final String? userName,
    final String? phoneNumber,
  }) {
    return UserPersonalInfo(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo =
        context.select<BottomNavBarVm, UserPersonalInfo>((vm) => vm.userInfo);
    const fontStyle = TextStyle(fontSize: 30);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${userInfo.email}', style: fontStyle),
            Text(
              'Username: ${userInfo.userName??''}',
              style: fontStyle,
            ),
            Text(
              'Phone number: ${userInfo.phoneNumber??''}',
              style: fontStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: context.read<BottomNavBarVm>().onProfileEditPressed,
      ),
    );
  }
}
