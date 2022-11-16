import 'package:cult_events/Screens/HomeScreen%201st/categories_inner.dart';
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
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return shimmerCategories(context);
            case ConnectionState.none:
              return shimmerCategories(context);

            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some error occurred"),
                );
              } else {
                final data = snapshot.data!.docs;

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
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final id = FirebaseFirestore.instance
                          .collection('categories')
                          .doc(snapshot.data!.docs[index].id).id;
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              //print()
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>  InnerCategories(uid: id,title: data[index]['title'],

                                  ),
                                ),
                              );
                              print(id);
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
                                      data[index]['image'],
                                      errorBuilder:
                                          (context, exception, stackTrace) {
                                        return shimmerError(context);
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 90,
                                  child: Text(
                                    data[index]['title'],
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
              }
          }
        });
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
              child: Column(
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
                        )),
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

  shimmerError(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      //margin: const EdgeInsets.all(20),
      height: 140,
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
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
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
