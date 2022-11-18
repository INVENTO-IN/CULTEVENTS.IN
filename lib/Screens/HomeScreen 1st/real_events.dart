import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RealEvents extends StatelessWidget {
  RealEvents({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('RealEvents').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return shimmerRealEvents(context);
        }
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        final data = snapshot.data!.docs;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          height: 380,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final image = data[index]['image'];
              final text = data[index]['title'];
              return Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 10, bottom: 10, top: 0),
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Container(

                      height: 380,
                      width: 280,
                      decoration: BoxDecoration(
                        //color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          //colorFilter:const  ColorFilter.mode(Colors.black12, BlendMode.color),
                          image: NetworkImage(image,

                          ),
                        ),
                      ),
                    //   child: Container(
                    //     //height: 100,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       gradient: LinearGradient(
                    //         begin: FractionalOffset.center,
                    //         end: FractionalOffset.bottomCenter,
                    //         colors: [
                    //           Colors.transparent.withOpacity(0.0),
                    //           Colors.black
                    //         ],
                    //         stops: const [0.5, 1.0],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10) ,bottomLeft: Radius.circular(10), ),
                          ),

                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    )
                    ),],
                ),
              );
            },
          ),
        );
      },
    );
  }
  shimmerRealEvents(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      height: 380,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 10, bottom: 10, top: 0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.5),
              highlightColor: Colors.white,
              child: Stack(
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    height: 380,
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                    ),
                    child: Container(
                      //height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.transparent.withOpacity(0.0),
                            Colors.black
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:Container(
                          color: Colors.white,
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
