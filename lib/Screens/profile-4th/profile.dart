import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../landing_page/landing_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title:const  Text("Profile "),
      ),
      body: Center(
        child: ElevatedButton(
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
      ),
    );
  }
}
