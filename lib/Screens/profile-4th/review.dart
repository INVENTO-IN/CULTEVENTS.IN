import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final controller = TextEditingController();
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Review',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Write a review for our services",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  //height: 100,
                  width: MediaQuery.of(context).size.width,

                  child: TextField(
                    controller: controller,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Write your experience... '),
                    maxLines: 10,
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              setState(() {
                isLoading = true;
              });

              final user = FirebaseAuth.instance.currentUser!.uid;
              if (user != null || controller.text.isNotEmpty) {
                final path = FirebaseFirestore.instance.collection('reviews');
                path.doc().set({'review': controller.text, 'uid': user});
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pop();
                return;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      "Submit",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
            ),
          ),
        ));
  }
}
