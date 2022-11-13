import 'package:cult_events/Screens/signin/otpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  final String phoneNumber;

  const SignUp({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showLoading = false;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final phoneNumber = widget.phoneNumber;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 50,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sign In/ Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black45,
                    ),
                  ),
                  //padding: const EdgeInsets.all(20),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: VerticalDivider(
                            color: Colors.black26,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          phoneNumber,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value) || value.length < 5) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  textInputAction: TextInputAction.done,
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.2,
                        color: Color.fromRGBO(230, 154, 141, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color:  Color.fromRGBO(235, 165, 54, 10), width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Enter correct email";
                    } else {
                      return null;
                    }
                  },
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0.2,
                        color: Color.fromRGBO(230, 154, 141, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(235, 165, 54, 10), width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        setState(() {
                          showLoading = true;
                        });
                        try {
                          await auth.verifyPhoneNumber(
                              phoneNumber: '+91$phoneNumber',
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
                                      color: const Color.fromRGBO(
                                          138, 80, 196, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              codeSent: (String SignUpVerificationId,
                                  int? token) async {
                                print(SignUpVerificationId);
                                print("Hiii");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupOtp(
                                      signUpVerificationID:
                                          SignUpVerificationId,
                                      phoneNumber: phoneNumber,
                                      userName: nameController.text,
                                      email: emailController.text,
                                    ),
                                  ),
                                );
                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                print(uid);
                                // await FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(auth.currentUser!.uid)
                                //     .set({
                                //   'phoneNumber': phoneNumber,
                                //   'userName': nameController.text,
                                //   'email': emailController.text,
                                //   'time': DateTime.now(),
                                // });

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
                                      color: const Color.fromRGBO(
                                          138, 80, 196, 60),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(snackBar);
                                setState(() {
                                  showLoading = false;
                                });
                                print(e);
                              });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: showLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
