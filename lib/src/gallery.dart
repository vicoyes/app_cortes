import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hair_app/src/imagenes.dart';
import 'package:http/http.dart' as http;

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return ClipRRect (
            borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ImagenGallery();
                }));
              },
              child: Image.network(
                'https://picsum.photos/id/${ids[index]}/300/300',
                loadingBuilder:
                    (context, Widget child, ImageChunkEvent loadingProgress) {
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
        itemCount: ids.length,
      ),
    );
  }
}
