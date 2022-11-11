import 'package:cult_events/Screens/profile-4th/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../landing_page/landing_page.dart';

class ProfileDetails extends StatefulWidget {
  final String? userName;
  final String? phoneNumber;
  final String? email;

  const ProfileDetails(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.email})
      : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final textStyle = const TextStyle(
      color: Colors.black26,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 11);

  @override
  Widget build(BuildContext context) {
    final name = widget.userName;
    final phoneNumber = widget.phoneNumber;
    final email = widget.email;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 45,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?fit=300%2C300&ssl=1"),
                radius: 70,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildColumn('Username', name),
            buildColumn('Email', email),
            buildColumn('Phone Number', phoneNumber),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                  );
                  print('Signed out');
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildColumn(String label, String? name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            name!,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
