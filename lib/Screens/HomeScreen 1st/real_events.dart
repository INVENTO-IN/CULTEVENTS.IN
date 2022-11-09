import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RealEvents extends StatelessWidget {
  RealEvents({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return const Text("Loading");
        }
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        final data = snapshot.data!.docs;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
                child:  Container(
                  height: 280,
                  width: 230,
                  child: Stack(

                    children: [
                      Image.network(
                        data[index]['image'],
                        fit: BoxFit.cover,
                      )
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
}
