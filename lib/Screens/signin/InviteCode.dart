import 'package:cult_events/Screens/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class InviteCode extends StatefulWidget {
  const InviteCode({Key? key}) : super(key: key);
  static const routeName = '/inviteCode-page';

  @override
  State<InviteCode> createState() => _InviteCodeState();
}

class _InviteCodeState extends State<InviteCode> {
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
              controller: phonenum,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Enter number",
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
                  if (phonenum.text == "8296770370") {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else if (phonenum.text == "9606158125") {


                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),

                      ),
                    );
                  }
                  print(phonenum.text);
                },
                child: const Text(
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
