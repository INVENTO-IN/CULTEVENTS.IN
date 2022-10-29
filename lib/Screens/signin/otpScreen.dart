import 'package:cult_events/Screens/HomeScreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;


  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp = TextEditingController();
  bool showLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(
            Icons.chevron_left_rounded,
            color:Theme.of(context).colorScheme.primary,
            size: 45,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Enter the OTP",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                autofocus: false,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                keyboardType: TextInputType.number,
                cursorColor:Theme.of(context).colorScheme.primary,
                textInputAction: TextInputAction.done,
                controller: otp,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Enter OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0.2,
                      color: Color.fromRGBO(230, 154, 141, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:const  BorderSide(
                        color: Color.fromRGBO(95, 74, 139, 1), width: 2),
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
                color:Theme.of(context).colorScheme.primary,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });
                    verifyCode();
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
                          "Submit",
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
    );
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp.text.toString());
    try {
      final Id = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      print(Id);
      await _auth.signInWithCredential(credential).then((value) {
        print("Logged in successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const  HomeScreen(),
          ),
        );
      });
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:const  Color.fromRGBO(138, 80, 196, 60),
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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      setState(() {
        showLoading = false;
      });
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
              Text(
                  'The sms code has expired or you entered a wrong code. Please try again.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
