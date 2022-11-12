import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cult_events/Screens/profile-4th/information.dart';
import 'package:cult_events/Screens/profile-4th/my_events.dart';
import 'package:cult_events/Screens/profile-4th/profile_details.dart';
import 'package:cult_events/Screens/profile-4th/review.dart';
import 'package:cult_events/bottomBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../landing_page/landing_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String phoneNo = "";
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future _getDataFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['userName'].toString();
          email = snapshot.data()!['email'];
          phoneNo = snapshot.data()!['phoneNumber'];
        });
      }
    });
  }

  Future userExisting() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    if (user.isEmpty) {
      print("invitecode");
      return false;
    } else {
      print("original");
      return true;
    }
  }

  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();

    userExisting();
    _getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        color: Colors.black87,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 15);

    if (user.isNotEmpty) {
      return Scaffold(
        //backgroundColor: Colors.black12,
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
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
                  MaterialPageRoute(builder: (ctx) => const BottomBar()));
            },
          ),

          // actions: [
          //   IconButton(
          //     onPressed: () async {
          //       await FirebaseAuth.instance.signOut();
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const LandingPage(),
          //         ),
          //       );
          //     },
          //     icon: Icon(
          //       Icons.logout_rounded,
          //       color: Theme.of(context).colorScheme.primary,
          //     ),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?fit=300%2C300&ssl=1"),
                      radius: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          name,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.mode_edit_outline_rounded,
                    //     color: Colors.black54,
                    //     size: 20,
                    //   ),
                    // )
                  ],
                ),
                const Divider(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileDetails(
                                        userName: name,
                                        phoneNumber: phoneNo,
                                        email: email,
                                      )));
                        },
                        child: const Text(
                          "Profile Details",
                          style: textStyle,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MyEvents()));
                        },
                        child: const Text(
                          "My Events",
                          style: textStyle,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () async {
                          String email = 'dhanushsujatha123@gmail.com';
                          String subject = 'Contact support';
                          String body = 'User Id: $uid';

                          String emailUrl =
                              "mailto:$email?subject=$subject&body=$body";
                          if (await canLaunch(emailUrl)) {
                            await launch(emailUrl);
                          } else {
                            throw "Error occurred sending an email";
                          }
                        },
                        child: const Text(
                          "Contact Support",
                          style: textStyle,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Review()));
                        },
                        child: const Text(
                          "Write a review",
                          style: textStyle,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Information()));
                        },
                        child: const Text(
                          "Information",
                          style: textStyle,
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
