import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hair_app/src/imagenes.dart';

import 'package:http/http.dart' as http;

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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
                          return ImagenGallery();
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Image.network(
                      'https://picsum.photos/id/${ids[index]}/400/300',
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
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child:
                                Icon(Icons.favorite_border, color: Colors.pink),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              setState(() {});
                            },
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
