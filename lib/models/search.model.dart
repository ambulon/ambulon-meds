import 'med.model.dart';

class SearchModel {
  List strList;
  List<MedicineModel> dataList;

  SearchModel(this.strList, this.dataList);

  // SearchModel.fromJson(Map<String, dynamic> json, List strListEvent, List<MedicineModel> ssrmL) {
  //   MedicineModel ssrm = MedicineModel.fromJson(json);
  //   ssrmL.add(ssrm);
  //   SearchModel(
  //     this.strList = strListEvent,
  //     this.dataList = ssrmL,
  //   );
  // }
}

// class SingleSearchResultModel {
//   String name;
//   List<MedicineModel> list;
//   SingleSearchResultModel(this.name, this.list);
//   SingleSearchResultModel.fromJson(List json, String str) {
//     List<MedicineModel> medList = [];
//     for (var m in json) {
//       medList.add(new MedicineModel.fromJson(m));
//     }
//     SingleSearchResultModel(
//       this.name = str,
//       this.list = medList,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {
//       "name": this.name,
//       "quantity": 1,
//       "priceList": {
//         for (var s in this.list) s.siteShort: s.price,
//       },
//     };
//     return data;
//   }
// }

// class MedicineModel {
//   String site;
//   double price;
//   String des;

//   MedicineModel(this.site, this.price, this.des);

//   MedicineModel.fromJson(Map<String, dynamic> json) {
//     MedicineModel(
//       this.site = json['site'] ?? "ambulon.com",
//       this.price = double.tryParse(json['price'].toString()) ?? 0.0,
//       this.des = json['description'] ?? "Description",
//     );
//   }

//   String get siteShort {
//     if (this.site.contains('netmeds')) {
//       return "netmeds";
//     } else if (this.site.contains('1mg')) {
//       return "_1mg";
//     } else if (this.site.contains('apollo')) {
//       return "apollo";
//     } else {
//       return "";
//     }
//   }
// }
