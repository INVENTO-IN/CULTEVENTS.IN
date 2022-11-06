import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

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

  final CarouselController _controller = CarouselController();
  Future<void> listPhotos() async {

  }

  // final ref = FirebaseStorage.instance.ref().child('carousel').getDownloadURL();
  //
  // void initState() {
  //   super.initState();
  //   var ref = FirebaseStorage.instance.ref().child('carousel');
  //   ref.getDownloadURL().then((loc) => setState(() => _imageUrl = loc));
  //
  // }

  //  Future<dynamic> loadImage() async {
  //
  //   var urlref =
  //       FirebaseStorage.instance.ref().child("carousel").listAll();
  //   var imageUrl = await urlref.listAll().then((value) {
  //     print("result is $value");
  //   });
  //   return imageUrl;
  //   // return await FirebaseStorage.instance
  //   //     .ref()
  //   //     .child("carousel")
  //   //     .child(image)
  //   //     .getDownloadURL();
  // }

  // Future<String> downloadUrl() async {
  //   String downloadUrl = await FirebaseStorage.instance
  //       .ref()
  //       .child('carousel')
  //       .child('14358')
  //       .getDownloadURL();
  //   return downloadUrl;
  // }

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

    return Column(
      children: [
        Row(
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
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 250),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
          ],
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
        // Expanded(
        //   //Image Loading code goes here
        //   child: FutureBuilder(
        //     future: _getImage(context, image),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done)
        //         return Container(
        //             height: MediaQuery.of(context).size.height / 1.25,
        //           width: MediaQuery.of(context).size.width / 1.25,
        //           child: snapshot.data,
        //         );
        //
        //       if (snapshot.connectionState == ConnectionState.waiting)
        //         return Container(
        //             height: MediaQuery.of(context).size.height / 1.25,
        //             width: MediaQuery.of(context).size.width / 1.25,
        //             child: CircularProgressIndicator());
        //
        //       return Container();
        //     },
        //   ),
        // ),

        // FutureBuilder(
        //   future: downloadUrl(),
        //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //     if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        //       return Container(
        //         width: 300,
        //         height: 300,
        //         child: Image.network(snapshot.data!),
        //       );
        //     }
        //     return Container();
        //     }
        //     )
        // ListView.builder(itemBuilder:(BuildContext context, int index) {
        //   return ClipRRect(
        //     child: SizedBox(
        //       height: 200,
        //       width: 200,
        //       child:
        //        NetworkImage(loadImage.toString()),
        //
        //     ),
        //   );
        // },
        // itemCount: 5,
        // )

        // SizedBox(height: 100,width: 100,
        //     child: Image.network(_imageUrl, fit: BoxFit.cover)),
      ],
    );
  }
}