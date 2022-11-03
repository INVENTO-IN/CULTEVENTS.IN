import 'package:cult_events/Screens/landing_page/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(138, 80, 196, 60),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text('Login Successful',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("HIi"),
        ),
        body: Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text("Press me"),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LandingPage(),
                ),
              );
            },
            child:const  Text("Log Out"),
          ),
        ],
      ),
    ));
  }
}
