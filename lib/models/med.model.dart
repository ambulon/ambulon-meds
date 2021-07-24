class MedicineModel {
  String id;
  String name;
  double onemg;
  double apollo;
  double netmeds;

  MedicineModel(
    this.id,
    this.name,
    this.onemg,
    this.apollo,
    this.netmeds,
  );

  MedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineModel(
      this.id = json['_id'] ?? "",
      this.name = json['name'] ?? "",
      this.onemg = double.tryParse(json['_1mg'].toString()) ?? 0.0,
      this.apollo = double.tryParse(json['apollo'].toString()) ?? 0.0,
      this.netmeds = double.tryParse(json['netmeds'].toString()) ?? 0.0,
    );
  }

  toJson() {
    return {
      "medicineId": this.id,
      "quantity": 1,
      "char": this.name[0].toLowerCase(),
    };
  }
}
