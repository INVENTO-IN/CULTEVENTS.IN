import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cult_events/Screens/signin/otpScreen.dart';
import 'package:cult_events/Screens/signin/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/signin-page';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phonenum = TextEditingController();
  bool showLoading = false;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  // void _submitAuthForm(String phonenumber,
  //     String username,
  //     String email,){
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Sign In/ Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length != 10) {
                    return "Enter correct number";
                  } else {
                    return null;
                  }
                },
                maxLength: 10,
                autofocus: false,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                cursorColor: Theme.of(context).colorScheme.primary,
                textInputAction: TextInputAction.done,
                controller: phonenum,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Phone Number",
                  prefixIcon: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset('assets/images/india.png'),
                              ),
                              const VerticalDivider(
                                color: Colors.black26,
                                thickness: 1,
                              ),
                              const Text(
                                "(+91)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  FocusScope.of(context).unfocus();
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    setState(() {
                      showLoading = true;
                    });
                    CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('users');

                    // Get docs from collection reference
                    QuerySnapshot querySnapshot = await _collectionRef
                        .where('phoneNumber', isEqualTo: phonenum.text)
                        .get();
                    //print(querySnapshot);
                    // if(querySnapshot == null){
                    //   print('new user');
                    // }else{
                    //   print('existing user');
                    // }

                    // Get data from docs and convert map to List
                    final allData =
                        querySnapshot.docs.map((doc) => doc.data()).toList();
                    if (allData.isEmpty) {
                      print('new user');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(
                            phoneNumber: phonenum.text,
                          ),
                        ),
                      );
                    } else {
                      print('old user');
                      await auth.verifyPhoneNumber(
                          phoneNumber: '+91${phonenum.text}',
                          verificationCompleted: (_) {
                            setState(() {
                              showLoading = false;
                            });
                          },
                          verificationFailed: (e) {
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
                                    Expanded(
                                      child: Text(
                                        e.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            setState(() {
                              showLoading = false;
                            });
                            print(e.message);
                          },
                          codeSent: (String verificationId, int? token) async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                  verificationId: verificationId,
                                ),
                              ),
                            );
                            // await FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(auth.currentUser!.uid)
                            //     .set({
                            //   'phoneNumber': phonenum.text,
                            // });
                            // final  uid = FirebaseAuth.instance.currentUser!.uid;
                            // print(uid);

                            setState(() {
                              showLoading = false;
                            });
                          },
                          codeAutoRetrievalTimeout: (e) {
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
                                    Expanded(
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     snackBar);
                            setState(() {
                              showLoading = false;
                            });
                            print(e);
                          });

                      print(allData);

                      //FirebaseFirestore.instance.collection('users').doc();
                      print(phonenum.text);
                      // print(FirebaseAuth.instance.currentUser!.uid);
                      // if(FirebaseAuth.instance.currentUser!.uid.isNotEmpty){
                      //   print("exixting user");
                      //
                      // }
                    }
                  }
                },
                child: showLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Get otp",
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
