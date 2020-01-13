import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import 'imagenGallery.dart';

class Listado extends StatefulWidget {
  String categoria;
  Listado(this.categoria);

  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  bool _isFavorited;
  Map categoria;

  // compartir img

  void compartir(imgUrl) async {
    var request = await HttpClient().getUrl(Uri.parse(imgUrl));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Cortes de cabello', 'corte.png', bytes, 'image/png');
  }
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('cortes')
            .where('categoria', isEqualTo: this.widget.categoria)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimationLimiter(
                child: new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> datas = docs[index].data;

                return Card(
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    child: GestureDetector(
                      child: Image.network(
                        datas['Img'],
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                              child: Image(
                                  image: AssetImage('img/loading-1.png')));
                        },
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ImagenGallery(datas['imgs'], datas['Img'], datas['video'], false, docs[index].documentID),
                          ),
                        );
                        print(datas['Img']);
                      },
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            )),
          );
        });
  }
}

// ListView.builder(
//                 itemCount: docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   Map<String, dynamic> datas = docs[index].data;

//                    _isFavorited = datas['like'];

//                   return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: const Duration(milliseconds: 375),
//                     child: SlideAnimation(
//                       verticalOffset: 50.0,
//                       child: FadeInAnimation(
//                         child: Card(
//                           color: Colors.white,
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Column(
//                             children: <Widget>[
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     PageTransition(
//                                       type: PageTransitionType.rightToLeft,
//                                       child: ImagenGallery(datas['imgs']),
//                                     ),
//                                   );
//                                 },
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(5),
//                                       topRight: Radius.circular(5)),
//                                   child: Image.network(
//                                     datas['Img'],
//                                     loadingBuilder: (context, Widget child,
//                                         ImageChunkEvent loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                           child: Image(
//                                               image: AssetImage(
//                                                   'img/loading-1.png')));
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: Container(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Column(
//                                           children: <Widget>[
//                                             Container(
//                                               padding: EdgeInsets.all(0),
//                                               child:IconButton(
//                                                 icon: Icon(
//                                                     _isFavorited
//                                                         ? Icons.favorite
//                                                         : Icons.favorite_border,
//                                                     color: Colors.pink),
//                                                 onPressed: () {
//                                                   if (_isFavorited) {
//                                                     _isFavorited = false;
//                                                     Firestore.instance
//                                                         .collection('likes')
//                                                         .document(docs[index]
//                                                             .documentID)
//                                                         .delete();

//                                                   } else {
//                                                     _isFavorited = true;
//                                                     Firestore.instance
//                                                         .collection('likes')
//                                                         .document(docs[index]
//                                                             .documentID)
//                                                         .setData({
//                                                       'id': docs[index]
//                                                           .documentID,
//                                                       'url': docs[index]['Img'],
//                                                       'imgs': docs[index]
//                                                           ['imgs']
//                                                     });

//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Column(
//                                           children: <Widget>[
//                                             Container(
//                                               child: IconButton(
//                                                 icon: Icon(
//                                                   Icons.share,
//                                                   color: Colors.pink,
//                                                 ),
//                                                 onPressed: () {
//                                                   compartir(datas['Img']);
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
