import 'dart:math';
import 'package:medcomp/app.config.dart';
import 'package:medcomp/models/searchhistory.model.dart';

class MedicineModel {
  String id;
  String name;
  double onemg;
  double apollo;
  double netmeds;
  String image;
  // String manufacturer;
  // String chemicals;
  // String quantity;
  String des;

  MedicineModel(
    this.id,
    this.name,
    this.onemg,
    this.apollo,
    this.netmeds,
    this.image,
    this.des,
    // this.manufacturer,
    // this.chemicals,
    // this.quantity,
  );

  MedicineModel.fromJson(Map<String, dynamic> json) {
    String desc;
    if (json['size'] != null) {
      desc = json['size'];
    }
    if (json["manufacturer"] != null) {
      desc += "\n" + "Manufactured by " + json["manufacturer"];
    }
    if (json['composition'] != null) {
      desc += "\n" + "Compositions " + json["manufacturer"];
    }
    MedicineModel(
      this.id = json['_id'] ?? "",
      this.name = json['name'] ?? "",
      this.onemg = double.tryParse(json['_1mg'].toString()) ?? 0.0,
      this.apollo = double.tryParse(json['apollo'].toString()) ?? 0.0,
      this.netmeds = double.tryParse(json['netmeds'].toString()) ?? 0.0,
      this.image = json["imageUrl"] ??
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80',
      // this.manufacturer = "made by",
      // this.chemicals = "",
      // this.quantity = "",
      this.des = desc,
    );
  }

  toJson() {
    return {
      "medicineId": this.id,
      "quantity": 1,
      "char": this.name[0].toLowerCase(),
    };
  }

  double get bestBuyPrice {
    List<double> l = [];
    if (this.netmeds != -1) {
      l.add(this.netmeds);
    }
    if (this.apollo != -1) {
      l.add(this.apollo);
    }
    if (this.onemg != -1) {
      l.add(this.onemg);
    }
    return l.reduce(min);
  }

  String get bestBuySite {
    List<double> l = [];
    if (this.netmeds != -1) {
      l.add(this.netmeds);
    }
    if (this.apollo != -1) {
      l.add(this.apollo);
    }
    if (this.onemg != -1) {
      l.add(this.onemg);
    }
    if (l.reduce(min) == this.netmeds) {
      return AppConfig.netmeds;
    } else if (l.reduce(min) == this.apollo) {
      return AppConfig.apollo;
    } else if (l.reduce(min) == this.onemg) {
      return AppConfig.onemg;
    } else {
      return AppConfig.all;
    }
  }

  double brandToPrice(String brand) {
    switch (brand) {
      case AppConfig.netmeds:
        return this.netmeds;
        break;
      case AppConfig.apollo:
        return this.apollo;
        break;
      case AppConfig.onemg:
        return this.onemg;
        break;
      default:
        return -1;
    }
  }

  // String get des {
  //   return 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,';
  // }

  toSearchHistoryMap() {
    return SearchHistoryModel(id: this.id, image: this.image, name: this.name).toJson();
  }
}
