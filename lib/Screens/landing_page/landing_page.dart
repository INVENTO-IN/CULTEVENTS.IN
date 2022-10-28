import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const routeName = '/landing-page';

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: const Duration(milliseconds: 250),
              autoPlayCurve: Curves.ease,
            ),
            items: [
              imageContainer('assets/images/image1.jpg'),
              imageContainer('assets/images/image2.jpg'),
              imageContainer('assets/images/image3.jpg'),
              imageContainer('assets/images/image4.jpg')
            ],
          ),
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
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => SignIn()));
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
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Have an Invite Code?",
                          style: TextStyle(
                              color: Color.fromRGBO(95, 74, 139, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                )
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
