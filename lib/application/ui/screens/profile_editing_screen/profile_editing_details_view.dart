import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/router.dart';

class ProfileEditingDetailsView extends StatelessWidget {
  final int? id;
  const ProfileEditingDetailsView({Key? key, @pathParam this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(AppRouter.instance().currentPath);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(id.toString()),
      ),
    );
  }
}
