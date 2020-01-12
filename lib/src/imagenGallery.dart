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
  String imgUrl;
 
 @override
  void initState() {
     print(this.widget.id[0]);
     imgUrl = this.widget.id[0];
    super.initState();
  }
  
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
          body: Column(
            children: <Widget>[
              Container(
                  child:Image.network(imgUrl)
                  ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: this.widget.id.length,
                    itemBuilder: (context, index) {
                      List<dynamic> data = this.widget.id;

                      return GestureDetector(
                        onTap: () {
                         print(data[index]); 

                         setState(() {
                           imgUrl = data[index];
                         });

                        //   Navigator.push(
                        //       context,
                        //       PageTransition(
                        //           type: PageTransitionType.fade,
                        //           child: SingleImg(data[index])));
                        },

                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 100,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                child: Image.network(data[index],
                                    fit: BoxFit.cover, loadingBuilder: (context,
                                        Widget child,
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
