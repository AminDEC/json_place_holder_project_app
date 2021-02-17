import 'dart:convert';
import 'package:http/http.dart';

class Pic{
  int id;
  int albumId;
  String title;
  String url;
  String thUrl;

  Pic({
    this.id,
    this.albumId,
    this.url,
    this.title,
    this.thUrl,
});

  factory Pic.fromjson(Map<String , dynamic> json){
    return Pic(
    id : json['id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thUrl: json['thumbnailUr'],
    );
  }
}



class Network {
  final String url;

  Network(this.url);

  Future<Pic_List> loadPost() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      // ok
      // we got the data from json file
      return Pic_List.fromjson(json.decode(response.body));
    }else{
      // no we don`t get data
      // an error happend
      throw Exception("failed to get data from server");
    }
  }
}


class Pic_List{

  final List<Pic> pic_list;

  Pic_List({this.pic_list});

  factory Pic_List.fromjson(List<dynamic> fromjson){
    List<Pic> pic_list = new List<Pic>();
    pic_list = fromjson.map((e) => Pic.fromjson(e)).toList();
    return new Pic_List(pic_list: pic_list);
  }
}
