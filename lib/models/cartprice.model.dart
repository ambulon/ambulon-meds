class Price {
  double netmeds;
  double i1mg;
  double apollo;

  Price({this.netmeds, this.i1mg, this.apollo});

  Price.fromJson(Map<String, dynamic> json) {
    netmeds = double.tryParse(json['netmeds'].toString()) ?? double.infinity;
    i1mg = double.tryParse(json['_1mg'].toString()) ?? double.infinity;
    apollo = double.tryParse(json['apollo'].toString()) ?? double.infinity;
  }
}
