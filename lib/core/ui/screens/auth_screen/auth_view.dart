import 'package:flutter/material.dart';
import 'package:flutter_app/core/ui/screens/auth_screen/auth_view_model.dart';
import 'package:flutter_app/core/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((AuthViewModel vm) => vm.isLoading);
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SingleChildScrollView(
        child: SizedBox(
          height: isLoading
              ? MediaQuery.of(context).size.height + 50
              : MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(flex: 2, child: AuthField()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context, listen: false);
    final errorText = context.select((AuthViewModel vm) => vm.errorText);
    final isLoading = context.select((AuthViewModel vm) => vm.isLoading);
    return Column(
      children: [
        TextFormField(
          controller: vm.emailController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.5), width: 2),
            ),
            labelText: 'email',
            labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: TextFormField(
            controller: vm.passwordController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5),
                  width: 2,
                ),
              ),
              labelText: 'password',
              labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
              helperText: errorText,
              helperStyle: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: isLoading ? null : vm.signInWithEmailAndPassword,
                child: const Text('Войти'),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : vm.registerAccount,
              child: const Text('Регистрация'),
            ),
          ],
        ),
        const Text(
          'Забыл логин/пароль',
          style: TextStyle(color: Colors.white),
        ),
        if (isLoading)
          const LoadingWidget(
            isActive: true,
            size: 50,
            color: Colors.white,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
