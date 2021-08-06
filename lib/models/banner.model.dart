class BannerModel {
  String image;
  String type;

  BannerModel({this.image, this.type});

  BannerModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
  }
}
