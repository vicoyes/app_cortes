import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hair_app/src/imagenGallery.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('cortes')
            .where('like', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> docs = snapshot.data.documents;

          if (docs.length == 0) {
            return Center(
              child: Text('Por favor elige tu primer favorito'),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                Map<String, dynamic> datas = docs[index].data;

                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //   return ImagenGallery();
                      // }));
                      // print(datas);
                    },
                    child: Image.network(
                      datas['Img'],
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
              itemCount: docs.length,
            ),
          );
        });
  }
}
