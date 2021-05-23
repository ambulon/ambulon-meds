class SearchModel {
  List strList;
  List<SingleSearchResultModel> dataList;

  SearchModel(this.strList, this.dataList);

  SearchModel.fromJson(List json, List strListEvent, List<SingleSearchResultModel> ssrmL) {
    SingleSearchResultModel ssrm = SingleSearchResultModel.fromJson(json, strListEvent.last);
    ssrmL.add(ssrm);
    SearchModel(
      this.strList = strListEvent,
      this.dataList = ssrmL,
    );
  }
}

class SingleSearchResultModel {
  String name;
  List<MedicineModel> list;
  SingleSearchResultModel(this.name, this.list);
  SingleSearchResultModel.fromJson(List json, String str) {
    List<MedicineModel> medList = [];
    for (var m in json) {
      medList.add(new MedicineModel.fromJson(m));
    }
    SingleSearchResultModel(
      this.name = str,
      this.list = medList,
    );
  }
}

class MedicineModel {
  String site;
  double price;
  String des;

  MedicineModel(this.site, this.price, this.des);

  MedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineModel(
      this.site = json['site'] ?? "ambulon.com",
      this.price = double.tryParse(json['price'].toString()) ?? 0.0,
      this.des = json['description'] ?? "Description",
    );
  }
}
