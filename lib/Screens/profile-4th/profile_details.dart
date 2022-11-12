import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cult_events/Screens/landing_page/landing_page.dart';
import 'package:cult_events/Screens/profile-4th/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  File? image;

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .update({'image': image})
      //     .then((value) => print("Sucess"))
      //     .catchError((error) => print("Failed $error"));

      print(image.path);
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?fit=300%2C300&ssl=1"),
                        radius: 70,
                      )
                    : SizedBox(
                        height: 140,
                        width: 140,
                        child: ClipOval(
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,

                            //fit: BoxFit.cover,
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 2,
                  right: 1.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          50,
                        ),
                      ),
                    ),
                    child: IconButton(
                      onPressed: _pickImage, // () => ImageSource.gallery,
                      icon: const Icon(
                        Icons.mode_edit_outline_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildColumn('Username', name),
            buildColumn('Email', email),
            buildColumn('Phone Number', phoneNumber),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1.0, color: Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>  LandingPage(),
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
