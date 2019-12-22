import 'package:flutter/material.dart';
import 'package:hair_app/src/signleimg.dart';
import 'package:page_transition/page_transition.dart';

class ImagenGallery extends StatefulWidget {
  final List<dynamic> id;
  ImagenGallery(this.id);

  @override
  _ImagenGalleryState createState() => _ImagenGalleryState();
}

class _ImagenGalleryState extends State<ImagenGallery> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
          backgroundColor: Colors.grey[900],
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: this.widget.id.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                List<dynamic> data = this.widget.id;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SingleImg(data[index]) ));
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: Image.network(data[index], fit: BoxFit.cover,
                          loadingBuilder: (context, Widget child,
                              ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Image(
                            image: AssetImage('img/loading-2.png'),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
