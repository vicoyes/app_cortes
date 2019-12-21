// dependencias
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:io';

// widget
import 'favoriteButton.dart';
import 'imagenGallery.dart';


class Largo extends StatefulWidget {
  @override
  _LargoState createState() => _LargoState();
}

class _LargoState extends State<Largo> {
  bool loading;
  List<String> ids;
  List<Map> idimgs;
  var _imageFile;
  bool like;

  @override
  void initState() {
    loading = true;
    ids = [];
    idimgs = [];
    like = false;

    _loadImageIds();
    super.initState();
  }

  void _loadImageIds() async {
    final response =
        await http.get('https://app-cabellos.firebaseio.com/cortes.json');
    final json = jsonDecode(response.body);

    List<String> _url = [];
    List<Map> _idimgs = [];

    for (var image in json) {
      if (image["Categoria"] == "Cortos") {
        _url.add(image["imagen"]);
        _idimgs.add(image);
      }
    }

    if (this.mounted) {
      setState(() {
        loading = false;
        ids = _url;
        idimgs = _idimgs;
      });
    }
    print(idimgs);
  }

  // Funcion para descargar activar si deseas activar la funcion descargar

  // void _onImageSaveButtonPressed(urlImage) async {
  //   print("_onImageSaveButtonPressed");
  //   var response = await http.get(urlImage);

  //   debugPrint(response.statusCode.toString());

  //   var filePath =
  //       await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

  //   var savedFile = File.fromUri(Uri.file(filePath));
  //   setState(() {
  //     _imageFile = Future<File>.sync(() => savedFile);
  //   });

  //   print(_imageFile);
  // }

  // compartir img

  void compartir(imgUrl) async {
    var request = await HttpClient().getUrl(Uri.parse(imgUrl));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Cortes de cabello', 'corte.png', bytes, 'image/png');
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        itemCount: ids.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ImagenGallery(idimgs[index]["id"]);
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Image.network(
                      ids[index],
                      loadingBuilder: (context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child:
                                Image(image: AssetImage('img/loading-1.png')));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(0),
                                child:FavoriteButton(ids[index], idimgs[index]["id"]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.pink,
                                    ),
                                    onPressed: () async {
                                      compartir(ids[index]);
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
