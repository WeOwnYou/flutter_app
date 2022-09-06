import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/application/ui/screens/bottom_nav_bar_screen/bottom_nav_bar_vm.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';
import 'package:provider/provider.dart';

class ProfileEditingVm extends ChangeNotifier {
  final BuildContext context;
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _userNameController = TextEditingController();
  bool _isLoading = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get userNameController => _userNameController;
  bool get isLoading => _isLoading;

  ProfileEditingVm(this.context, {required UserPersonalInfo userInfo}) {
    _emailController.text = userInfo.email;
    _phoneNumberController.text = userInfo.phoneNumber ?? '';
    _userNameController.text = userInfo.userName ?? '';
  }

  Future<void> onSaveButtonTap() async {
    _isLoading = true;
    notifyListeners();
    await context.read<BottomNavBarVm>().changeUserInfo(
          UserPersonalInfo(
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            userName: userNameController.text,
          ),
        );
    unawaited(context.router.pop());
  }
}
