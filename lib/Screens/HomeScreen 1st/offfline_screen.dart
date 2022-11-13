import 'package:cult_events/service/network_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Offline extends StatelessWidget {
  final Widget child;
  const Offline({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return Scaffold(
      body: networkStatus == NetworkStatus.online ? child : const  Center(child:  Text("Please connect to internet")),
    );
  }
}