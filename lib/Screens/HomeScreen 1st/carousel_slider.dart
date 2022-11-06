import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    //print(urls);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final file = FirebaseFile(ref: ref, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}

class FirebaseFile {
  final Reference ref;
  final String url;

  const FirebaseFile({required this.ref, required this.url});
}

final List<String> imgList = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
  'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
  'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
];

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;


  // static Future<List<String>> _getDownloadLinks(List<Reference> refs) => Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
  // static Future<List<FirebaseFile>> listAll() async {
  //   final ref = FirebaseStorage.instance.ref('carousel/');
  //   final result = await ref.listAll();
  //   final urls = await _getDownloadLinks(result.items);
  //   print(urls);
  //   return urls
  //       .asMap()
  //       .map((index, url) {
  //     final ref = result.items[index];
  //     final file = FirebaseFile(ref: ref, url: url);
  //     print(ref);
  //     print(file);
  //     return MapEntry(index, file);
  //
  //   }).values
  //       .toList();
  // }
  void getImage() async {
    final ref = await FirebaseStorage.instance.ref('carousel/').listAll();
    print(ref);
  }

  final CarouselController _controller = CarouselController();

  //
  late Future<List<FirebaseFile>> futureFiles;
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll('carousel/');
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((image) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.network(image,
                      fit: BoxFit.cover,
                      width:
                          1000.0) // Image.asset(image, fit: BoxFit.cover, width: 1000.0),
                  ),
            ))
        .toList();
    //final List<Widget> image = ListImage.map((imageList) => )

    return Column(
      children: [
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 250),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        //Image.network('https://firebasestorage.googleapis.com/v0/b/cultevents-de04a.appspot.com/o/carousel%2F14358.jpg?alt=media&token=17a3d95b-cf34-4102-859e-6f6ac9138942'),

        FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occurred"),
                  );
                } else {
                  final files = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          //shrinkWrap: true,
                         itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index % files.length];
                            return buildFile(context, file);
                          },
                        ),
                      )
                    ],
                  );
                }
            }
          },
        ),

      ],
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => AnimatedContainer(
    duration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            file.url,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
}
