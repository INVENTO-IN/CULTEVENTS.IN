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

      body: networkStatus == NetworkStatus.online
          ? child
          : Center(
              child: Text(
                "Looks like you're offline!",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
    );
  }
}
class OfflineStatic extends StatelessWidget {
  const OfflineStatic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  Text("Turn on internet"),
      ),
    );
  }
}
