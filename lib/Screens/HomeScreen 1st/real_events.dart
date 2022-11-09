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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
                      ),
                      height: 380,
                      width: 280,
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
                                stops: const [
                                  0.5,
                                  1.0
                                ])),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    )
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
