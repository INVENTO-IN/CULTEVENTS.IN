import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class NearYouInner extends StatelessWidget {
  final String uid;
  final String title;

  const NearYouInner({Key? key, required this.uid, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> users = FirebaseFirestore
        .instance
        .collection('nearYou')
        .doc(uid)
        .collection(title)
        .snapshots();
    TextStyle textStyle = const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Poppins');
    //print(uid);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 45,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("waiting");
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          final data = snapshot.data!.docs;
          final width = MediaQuery.of(context).size.width;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            width: width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(

              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          height: 400,
                          width: width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              data[index]['image'],
                              errorBuilder: (ctx, object, stackTrace) {
                                return const Text("error");
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[index]['title'],
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[index]['location'],
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                          //style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${data[index]['price']}',
                          //"₹" + data[index]['price'],
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle2,
                          //style:
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),

          );
        },
      ),
    );
  }
}
