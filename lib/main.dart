import 'package:cult_events/Screens/landing_page/landing_page.dart';
import 'package:cult_events/Screens/signin/InviteCode.dart';
import 'package:cult_events/Screens/signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CultEvents',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(138,80,196, 10), //purple
          secondary: Colors.white,
        ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: const Color.fromRGBO(138,80,196, 10),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
              bodyText2: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
              ),
              subtitle1: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromRGBO(138,80,196,10),
              ),
          subtitle2: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Color.fromRGBO(138,80,196, 10),
          ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const LandingPage(),
        SignIn.routeName: (ctx) => SignIn(),
        InviteCode.routeName: (ctx) => InviteCode(),

      },
    );
  }
}
