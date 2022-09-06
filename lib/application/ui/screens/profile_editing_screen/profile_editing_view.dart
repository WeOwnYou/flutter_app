import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/router.dart';
import 'package:flutter_app/application/ui/screens/profile_editing_screen/profile_editing_vm.dart';
import 'package:flutter_app/application/ui/screens/profile_screen/profile_view.dart';
import 'package:flutter_app/core/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ProfileEditingView extends StatelessWidget implements AutoRouteWrapper {
  final UserPersonalInfo userInfo;
  final int? id;
  const ProfileEditingView(
      {super.key, required this.userInfo, @pathParam this.id});

  @override
  Widget build(BuildContext context) {
    final userNameController =
        context.read<ProfileEditingVm>().userNameController;
    final phoneNumberController =
        context.read<ProfileEditingVm>().phoneNumberController;
    final emailController = context.read<ProfileEditingVm>().emailController;
    final isLoading =
        context.select<ProfileEditingVm, bool>((vm) => vm.isLoading);
    print('${AppRouter.instance().currentPath}!!');
    // print('${context.router.current.path}??');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.instance().push(ProfileEditingDetailsRoute(id: 14));
              },
              icon: const Icon(Icons.abc))
        ],
      ),
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
        onPressed:
            isLoading ? null : context.read<ProfileEditingVm>().onSaveButtonTap,
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProfileEditingVm(
        ctx,
        userInfo: userInfo,
      ),
      child: this,
    );
  }
}
