import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//
// class FirebaseApi {
//   static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
//       Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
//
//   static Future<List<FirebaseFile>> listAll(String path) async {
//     final ref = FirebaseStorage.instance.ref(path);
//     final result = await ref.listAll();
//     final urls = await _getDownloadLinks(result.items);
//     //print(urls);
//
//     return urls
//         .asMap()
//         .map((index, url) {
//           final ref = result.items[index];
//           final file = FirebaseFile(ref: ref, url: url);
//
//           return MapEntry(index, file);
//         })
//         .values
//         .toList();
//   }
// }
//
// class FirebaseFile {
//   final Reference ref;
//   final String url;
//
//   const FirebaseFile({required this.ref, required this.url});
// }
//
// final List<String> imgList = [
//   'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
//   'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
//   'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
// ];

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselController _controller = CarouselController();
  final Future<QuerySnapshot> carouselSlider =
      FirebaseFirestore.instance.collection('carousel').get();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: carouselSlider,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: Text("Loading"));
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occurred"),
                  );
                } else {
                  final images = snapshot.data!.docs;
                  return SizedBox(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, index, _) {
                        //final file = files[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              images[index]['image'],
                              width: 1000,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction: 0.9,
                        aspectRatio: 1.5,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 550),
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              _current = index;
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
            }
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: futureFiles.asMap().entries.map((entry) {
        //     return GestureDetector(
        //       onTap: () => _controller.animateToPage(entry.key),
        //       child: Container(
        //         width: 8.0,
        //         height: 8.0,
        //         margin:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: (Theme.of(context).brightness == Brightness.dark
        //                     ? Colors.white
        //                     : Colors.black)
        //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
        //       ),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

// Widget buildFile(BuildContext context, FirebaseFile file) =>
//     AnimatedContainer(
//       duration: const Duration(milliseconds: 350),
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           file.url,
//           width: 1000,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
}
