import 'package:cult_events/Screens/HomeScreen%201st/carousel_slider.dart';
import 'package:cult_events/Screens/HomeScreen%201st/catergories.dart';
import 'package:cult_events/Screens/HomeScreen%201st/ideas.dart';
import 'package:cult_events/Screens/HomeScreen%201st/near_u.dart';
import 'package:cult_events/Screens/HomeScreen%201st/real_events.dart';
import 'package:cult_events/service/network_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NetworkServices>(
      create: (ctx) => NetworkServices.instance(),
      builder: (ctx, child) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: SizedBox(
              height: 45,
              child: Image.asset("assets/images/Logo.png"),),
          ),
          body: Consumer<NetworkServices>(
            builder: (ctx, network, child) {
              print("rebuilt");
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Categories(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Carousel(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Near you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    NearYou(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 15),
                      child: Text(
                        "Ideas for you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Ideas(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 15),
                      child: Text(
                        "Real events we love",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    RealEvents(),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
