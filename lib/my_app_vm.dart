import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/ui/overlay/connectivity_overlay.dart';

class MyAppVm extends ChangeNotifier{
  BuildContext context;
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  MyAppVm(this.context){
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async{
    await _onConnectivityChanged(await Connectivity().checkConnectivity());
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  Future<void> _onConnectivityChanged(ConnectivityResult? e) async{
    if(e == ConnectivityResult.none) {
      ConnectivityOverlay.instance.showOverlay(context, 'No internet');
    }
    else{
      ConnectivityOverlay.instance.removeOverlay();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
