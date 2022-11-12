import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cult_events/Screens/signin/InviteCode.dart';
import 'package:cult_events/Screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';

  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<QuerySnapshot> carouselSlider =
      FirebaseFirestore.instance.collection('landingPage').get();

  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder<QuerySnapshot>(
              future: carouselSlider,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: Text("Loading"));
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Center(child: Text("Some error occurred")),
                      );
                    } else {
                      final images = snapshot.data!.docs;
                      return CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, index, _) {
                          final image = images[index]['image'];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            //margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image),
                                ),
                              ),
                              child: Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(
                                    begin: FractionalOffset.center,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                      Colors.transparent.withOpacity(0.0),
                                      Colors.black,
                                    ],
                                    stops: [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          viewportFraction: 1.0,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          autoPlayInterval: const Duration(
                            seconds: 3,
                          ),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          autoPlayCurve: Curves.ease,
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                _current = index;
                              },
                            );
                          },
                        ),
                      );
                    }
                }
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignIn.routeName);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      "Sign In/Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, InviteCode.routeName);
                        },
                        child: const Text("Have an Invite Code?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget imageContainer(String image) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: FractionalOffset.center,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.transparent.withOpacity(0.0),
            Colors.black,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
    ),
  );
}
