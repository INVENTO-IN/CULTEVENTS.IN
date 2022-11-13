import 'package:cult_events/Screens/HomeScreen%201st/offfline_screen.dart';
import 'package:cult_events/Screens/landing_page/landing_page.dart';
import 'package:cult_events/Screens/signin/InviteCode.dart';
import 'package:cult_events/Screens/signin/signin.dart';
import 'package:cult_events/bottomBar.dart';
import 'package:cult_events/service/network_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => NetworkServices().controller.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
        title: 'CultEvents',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color.fromRGBO(235, 165, 54, 10),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(235, 165, 54, 10), //purple
            secondary: Colors.white,
          ),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: const Color.fromRGBO(138, 80, 196, 10),
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
                  fontSize: 17,
                  color: Colors.white,
                ),
                subtitle1: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.black,
                ),
                subtitle2: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              FlutterNativeSplash.remove();
              return const Offline(child:  BottomBar());
            }
            FlutterNativeSplash.remove();
            return LandingPage();
          },
        ),
        //initialRoute: '/',
        routes: {
          LandingPage.routeName: (ctx) => LandingPage(),
          SignIn.routeName: (ctx) => const SignIn(),
          InviteCode.routeName: (ctx) => const InviteCode(),
        },
      ),
    );
  }
}
