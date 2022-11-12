import 'package:cult_events/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../HomeScreen 1st/homeScreen.dart';

class InviteCode extends StatefulWidget {
  const InviteCode({Key? key}) : super(key: key);
  static const routeName = '/inviteCode-page';

  @override
  State<InviteCode> createState() => _InviteCodeState();
}

class _InviteCodeState extends State<InviteCode> {
  TextEditingController code = TextEditingController();
  bool showLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Enter the code",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              autofocus: false,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              keyboardType: TextInputType.number,
              cursorColor: Theme.of(context).colorScheme.primary,
              textInputAction: TextInputAction.done,
              controller: code,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Enter Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 0.2,
                    color: Color.fromRGBO(230, 154, 141, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
              child: MaterialButton(
                //padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  CollectionReference _collectionRef =
                      FirebaseFirestore.instance.collection('inviteCode');

                  // Get docs from collection reference
                  QuerySnapshot querySnapshot = await _collectionRef
                      .where('code', isEqualTo: code.text)
                      .get();

                  final allData =
                      querySnapshot.docs.map((doc) => doc.data()).toList();

                  if (allData.isEmpty) {
                    print("incorrect");
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
                              child: Text('Entered Code is invalid!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                      ),
                    );
                    setState(() {
                      showLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    setState(() {
                      showLoading = true;
                    });
                    print('correct');
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(235, 165, 54, 10),
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
                    setState(() {
                      showLoading = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => BottomBar()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  print(code.text);
                  print(allData);
                },
                child: showLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Verify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 17,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
