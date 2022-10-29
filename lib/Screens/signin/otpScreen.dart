import 'package:cult_events/Screens/HomeScreen/homeScreen.dart';
import 'package:cult_events/Screens/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class otp extends StatefulWidget {
  final String verificationId;

  const otp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController otp = TextEditingController();
  bool showLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Color.fromRGBO(95, 74, 139, 1),
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
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(95, 74, 139, 1),
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
                    borderSide: BorderSide(
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
                color: Color.fromRGBO(95, 74, 139, 1),
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
                      ?  SizedBox(
                    height: 20,
                        width: 20,
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
      await _auth.signInWithCredential(credential).then((value) {
        print("Logged in succesfully");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
      final snackBar = SnackBar(content: Text("Login Successful"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      setState(() {
        showLoading =  false;
      });
      // final snackBar =  SnackBar(
      //     content:  Text(
      //         "The sms code has expired or you entered a wrong code. Please re-send the code to try again."));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
