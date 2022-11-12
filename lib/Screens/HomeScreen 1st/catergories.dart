import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('categories').snapshots();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (ConnectionState.waiting == snapshot.connectionState) {
          return  shimmerCategories(context);
        }
        final data = snapshot.requireData;
        return Container(
          padding: const EdgeInsets.all(10),
          //margin: const EdgeInsets.all(20),
          height: 130,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  child: InkWell(
                    onTap: () {
                      print(data.docs[index]['title']);
                    },
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data.docs[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 90,
                          child: Text(
                            data.docs[index]['title'],
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

   shimmerCategories(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      //margin: const EdgeInsets.all(20),
      height: 130,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade200,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: Shimmer.fromColors(

                baseColor: Colors.grey.withOpacity(.5),
                highlightColor: Colors.white,
            child:  Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 65,
                  width: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 10,
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,

                    ),
                  ),
                ),
              ],
            ),
            ),
          );
        },
      ),
    );
  }
}

// class ShimmerCategories extends StatefulWidget {
//   const ShimmerCategories({Key? key}) : super(key: key);
//
//   @override
//   State<ShimmerCategories> createState() => _ShimmerCategoriesState();
// }
//
// class _ShimmerCategoriesState extends State<ShimmerCategories> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
//
