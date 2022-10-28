import 'package:flutter/material.dart';

String verificationIDReceived = "";

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/signin-page';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phonenum = TextEditingController();
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
            child: TextFormField(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
              child: MaterialButton(
                //padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  print(phonenum.text);
                },
                child: const Text("Get otp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 17)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
