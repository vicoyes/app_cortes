import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';

class ImagenGallery extends StatefulWidget {
  @override
  _ImagenGalleryState createState() => _ImagenGalleryState();
}

class _ImagenGalleryState extends State<ImagenGallery> {
  bool loading;
  List<String> ids;

  @override
  void initState() {
    loading = true;
    ids = [];

    _loadImageIds();
    super.initState();
  }

  void _loadImageIds() async {
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);

    List<String> _ids = [];

    for (var image in json) {
      _ids.add(image['id']);
    }

    if (this.mounted) {
      setState(() {
        loading = false;
        ids = _ids;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    @override
    var uriMage = Image.network('https://picsum.photos/id/0/400/300');

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
        backgroundColor: Colors.grey[900dd],
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 8,
            textTheme: TextTheme(
                title: TextStyle(
              color: Colors.pink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )),
            title: Text('Galeria'),
          ),
          body: Center(
            child: Container(
              height: 300,
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  child: new Image.network(
                      'https://picsum.photos/id/${ids[index]}/300/300',
                      fit: BoxFit.fill,
                    ),
                  );
                },
                itemCount: ids.length,
                itemWidth: 300.0,
                layout: SwiperLayout.STACK,
                control: new SwiperControl(),
                loop: false,

              ),
            ),
          )),
    );
  }
}

// Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   child: uriMage,
//                 ),
//               ),
//               Expanded(
//                               child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: ids.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Row(
//                           children: <Widget>[
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   uriMage = Image.network('https://picsum.photos/id/${ids[index]}/400/300');
//                                 });
//                                 print(uriMage);
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(5),
//                                       ),
//                                   child: Image.network(
//                                     'https://picsum.photos/id/${ids[index]}/150/150',
//                                     loadingBuilder: (context, Widget child,
//                                         ImageChunkEvent loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                           child: Image(
//                                               image: AssetImage('img/loading-2.png')));
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );

//                     }),
//               ),
//             ],
//           ),
//         ),
