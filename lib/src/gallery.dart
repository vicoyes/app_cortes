import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hair_app/src/imagenGallery.dart';
import 'package:page_transition/page_transition.dart';

class Gallery extends StatefulWidget {
final String userId;
Gallery(this.userId);

 @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('data').document(this.widget.userId).collection('likes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;
          if (docs.length == 0) {
            return 
                Center(
                  child: Text('Por favor elige tu primer favorito'),
                ); 
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: docs.length,
            staggeredTileBuilder: (int index) =>
                  new StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemBuilder: (BuildContext context, int index){
                Map<String, dynamic> datas = docs[index].data;

                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ImagenGallery( datas['imgs'], datas['Img'],
                              datas['video'], true, datas['id']),
                        ),
                      );
                      print('data_video: ${datas['video']}');
                    },
                    child: Image.network(
                      datas['url'],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Image(
                            image: AssetImage('img/loading-2.png'),
                          ),
                        );
                      },
                    ),
                  ),
                );

              },
            )
          );
        });
  }
}

