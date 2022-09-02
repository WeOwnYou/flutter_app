import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';

class BottomNavBarVm extends ChangeNotifier {
  BuildContext context;
  final User _user;
  bool _isLoading = false;
  late UserPersonalInfo _userInfo;

  bool get isLoading => _isLoading;
  UserPersonalInfo get userInfo => _userInfo;

  BottomNavBarVm(this.context) : _user = FirebaseAuth.instance.currentUser! {
    _loadUserInfo();
  }
  void _loadUserInfo([UserPersonalInfo? userPersonalInfo]) {
    _userInfo = UserPersonalInfo(
      email: userPersonalInfo?.email ?? _user.email!,
      userName: userPersonalInfo?.userName ?? _user.displayName,
      phoneNumber: userPersonalInfo?.phoneNumber ?? _user.phoneNumber,
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeUserInfo(UserPersonalInfo userInfo) async {
    _isLoading = true;
    notifyListeners();
    await _user.updateEmail(userInfo.email);
    await _user.updateDisplayName(userInfo.userName);
    _loadUserInfo(userInfo);
  }

  void onProfileEditPressed() {
    context.router.pushNamed(Routes.profileEditingScreen);
  }
}
