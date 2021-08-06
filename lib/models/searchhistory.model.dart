import 'dart:convert';

class SearchHistoryModel {
  String image;
  String id;
  String name;

  SearchHistoryModel({this.image, this.id, this.name});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
  }

  toJson() {
    var data = {
      "image": this.image,
      "id": this.id,
      "name": this.name,
    };
    return jsonEncode(data);
  }
}
