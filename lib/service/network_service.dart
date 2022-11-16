import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum NetworkStatus { online, offline }

class NetworkServices extends ChangeNotifier{
  NetworkServices.instance();
  StreamController<NetworkStatus> controller = StreamController();
  NetworkServices() {
    Connectivity().onConnectivityChanged.listen((event) {
      controller.add(_networkStatus(event));
      notifyListeners();
    });

  }

  NetworkStatus _networkStatus(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
