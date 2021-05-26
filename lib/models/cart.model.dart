import 'dart:math';

class CartModel {
  List<Items> items;
  Price totalPrice;

  CartModel({this.items, this.totalPrice});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'] != null ? new Price.fromJson(json['totalPrice']) : null;
  }
}

class Items {
  String name;
  int quantity;
  Price price;

  Items({this.name, this.quantity, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }
}

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

  double get minPrice {
    print(netmeds);
    print(i1mg);
    print(apollo);
    // return apollo;
    double m = 0.0;
    if (netmeds > i1mg) {
      m = i1mg;
    } else {
      m = netmeds;
    }
    if (m > apollo) {
      m = apollo;
    }
    // m = m < apollo ? m : apollo;
    // double first = min(netmeds, i1mg);
    return m;
  }
}
