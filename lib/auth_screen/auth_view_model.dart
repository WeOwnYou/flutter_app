import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/home_screen/home_view.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final BuildContext _context;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorText = '';

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  String get errorText => _errorText;

  AuthViewModel(this._context) {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> registerAccount(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      _errorText = '';
    } on FirebaseAuthException catch (e) {
      _errorText = e.message ?? '';
    }
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword() async {
    const secureStorage = FlutterSecureStorage();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      _errorText = '';
      secureStorage.write(key: 'email', value: _emailController.text);
      secureStorage.write(key: 'password', value: _passwordController.text);
      _navigateToHomeScreen();
    } on FirebaseAuthException catch (e) {
      secureStorage.delete(key: 'email');
      secureStorage.delete(key: 'password');
      _errorText = e.message ?? '';
    }
    notifyListeners();
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(_context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: HomeViewModel.new,
          child: const HomeView(),
        ),
      ),
    );
  }
}
