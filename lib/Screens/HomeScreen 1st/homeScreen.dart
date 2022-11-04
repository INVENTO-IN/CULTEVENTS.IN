import 'package:cult_events/Screens/HomeScreen%201st/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("CultEvents"),
        ),
        body: Column(
          children:const [
            Carousel(),
          ],
        ));
  }
}
