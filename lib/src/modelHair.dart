import 'package:http/http.dart' as http;
import 'dart:convert';


class Choice {
  const Choice({this.title, this.id, this.lista});

  final String title;
  final int id;
  final List lista;
}

bool loading;
List<String> url;

@override
  void initState() {
    loading = true;
    url = [];

    _loadImageIds();
  }

  void _loadImageIds() async {
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);

    List<String> _url =[];

    for (var image in json) {
      _url.add(image['url']);
    }

    _url = url;

  }

 

@override
const List<Choice> choices = const <Choice>[
  const Choice(title: 'Popular', id: 45, lista: [
    'https://www.tekcrispy.com/wp-content/uploads/2017/12/bancos-imagenes-gratis-640x422.jpg',
    'https://images.unsplash.com/photo-1575859694244-0b337bf58e0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1868&q=80'
  ]),
  const Choice(title: 'Cabello Corto', id: 60, lista: [
    'https://images.unsplash.com/photo-1575859694244-0b337bf58e0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1868&q=80'
  ]),
  const Choice(title: 'Cabello Medio', id: 25, lista: [
    'https://www.tekcrispy.com/wp-content/uploads/2017/12/bancos-imagenes-gratis-640x422.jpg'
  ]),
  const Choice(title: 'Cabello Largo', id: 75, lista: [
    'https://www.tekcrispy.com/wp-content/uploads/2017/12/bancos-imagenes-gratis-640x422.jpg'
  ]),
];
