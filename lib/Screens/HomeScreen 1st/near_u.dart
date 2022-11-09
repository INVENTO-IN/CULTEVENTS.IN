import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NearYou extends StatelessWidget {
  NearYou({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        //if(ConnectionState.none)
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        final data = snapshot.data!.docs;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: 220,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            physics:const  BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          data[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(data[index]['title'],
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(data[index]['title'],
                        textAlign: TextAlign.start,
                        style:const  TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontWeight: FontWeight.w400),
                        //style: Theme.of(context).textTheme.subtitle2,
                      ),
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
