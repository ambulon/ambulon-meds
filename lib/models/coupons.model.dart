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
}
