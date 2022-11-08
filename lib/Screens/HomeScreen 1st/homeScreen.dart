import 'package:cult_events/Screens/HomeScreen%201st/carousel_slider.dart';
import 'package:cult_events/Screens/HomeScreen%201st/catergories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:const  Text(
            "CultEvents",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 18

            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [

              Categories(),
              const  SizedBox(
                height: 10,
              ),
              const Carousel(),



            ],
          ),
        ));
  }
}
