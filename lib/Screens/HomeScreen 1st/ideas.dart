import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Ideas extends StatelessWidget {
  Ideas({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return shimmerIdeas(context);
        }
        //if(ConnectionState.none)
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        final data = snapshot.data!.docs;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 345,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 0),
                child: Card(
                  elevation: 2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 280,
                        width: 230,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            data[index]['image'],
                            errorBuilder: (ctx, object, stackTrace) {
                              return shimmerError(context);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            data[index]['title'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ),

                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(data[index]['title'],
                      //     textAlign: TextAlign.start,
                      //     style:const  TextStyle(
                      //         fontSize: 12,
                      //         fontFamily: 'Poppins',
                      //         color: Colors.black87,
                      //         fontWeight: FontWeight.w400),
                      //     //style: Theme.of(context).textTheme.subtitle2,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  shimmerIdeas(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      height: 345,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.5),
        highlightColor: Colors.white,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 0),
              child: Card(
                elevation: 2,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 280,
                      width: 230,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Container(
                            color: Colors.white,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 120,
                          child: Container(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  shimmerError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      height: 345,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.5),
        highlightColor: Colors.white,
        child: Card(
          elevation: 2,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 270,
                width: 220,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
