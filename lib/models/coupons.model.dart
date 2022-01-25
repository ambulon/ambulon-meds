import 'package:medcomp/app.config.dart';

class CouponsModel {
  String id;
  String des;
  String brand;

  CouponsModel(this.id, this.des, this.brand);

  CouponsModel.fromJson(Map<String, dynamic> json) {
    CouponsModel(
      this.id = json['code'] ?? "",
      this.des = json['desc'],
      this.brand = json['site'],
    );
  }

  // TODO : use getters if some computation is only for the current model
  // removed your map couponicon code from coupons and used this
  String get imageUrl {
    if (brand.toLowerCase() == AppConfig.apollo.toLowerCase())
      return "assets/apollo.jpg";
    else if (brand.toLowerCase() == AppConfig.netmeds.toLowerCase())
      return "assets/netmeds.jpg";
    else if (brand.toLowerCase() == AppConfig.onemg.toLowerCase())
      return "assets/onemg.png";
    else
      return "assets/app-logo.png";
  }
}
