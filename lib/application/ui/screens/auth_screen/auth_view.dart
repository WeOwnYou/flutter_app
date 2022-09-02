import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/auth_screen/auth_view_model.dart';
import 'package:flutter_app/core/ui/handlers/snack_bar_handler.dart';
import 'package:flutter_app/core/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget implements AutoRouteWrapper {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context, listen: false);
    final authModel =
        context.select<AuthViewModel, AuthModel>((vm) => vm.authModel);
    final decoration = InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.5), width: 2),
      ),
      labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
    );
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Авторизация',
        ),
      ),
      backgroundColor: Colors.pink,
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
                TextField(
                  onChanged: (input) => vm.changeAuthData(input, true),
                  decoration: decoration.copyWith(
                    labelText: 'email',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  onChanged: (input) => vm.changeAuthData(input, false),
                  obscureText: true,
                  decoration: decoration.copyWith(
                    labelText: 'password',
                    helperText: authModel.errorText,
                    helperStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: authModel.isLoading
                          ? null
                          : vm.signInWithEmailAndPassword,
                      child: const Text('Войти'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed:
                          authModel.isLoading ? null : vm.registerAccount,
                      child: const Text('Регистрация'),
                    ),
                  ],
                ),
                const Text(
                  'Забыл логин/пароль',
                  style: TextStyle(color: Colors.white),
                ),
                if (authModel.isLoading)
                  const LoadingWidget(
                    size: 50,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AuthViewModel(
        ctx,
        SnackBarErrorHandler(ctx),
      ),
      child: const AuthView(),
    );
  }
}
