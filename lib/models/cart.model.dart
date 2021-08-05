import 'package:medcomp/app.config.dart';
import 'cartitem.model.dart';
import 'cartprice.model.dart';

class CartModel {
  List<Item> items;
  Price totalPrice;
  double recPrice;
  String recBrand;

  CartModel({this.items, this.totalPrice, this.recBrand, this.recPrice});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'] != null ? new Price.fromJson(json['totalPrice']) : null;
    TempModel temp = recFind(items, totalPrice);
    recPrice = temp.price;
    recBrand = temp.name;
  }

  TempModel recFind(List<Item> items, price) {
    int cn = 0, ca = 0, co = 0;
    for (var i in items) {
      if (i.price.netmeds == -1) cn++;
      if (i.price.apollo == -1) ca++;
      if (i.price.i1mg == -1) co++;
    }
    List brands = [];
    if (cn <= ca && cn <= co) brands.add({"name": AppConfig.netmeds, "price": price.netmeds});
    if (ca <= cn && ca <= co) brands.add({"name": AppConfig.apollo, "price": price.apollo});
    if (co <= ca && co <= cn) brands.add({"name": AppConfig.onemg, "price": price.i1mg});
    if (brands.length == 0) {
      throw ("no valid data, clear cart");
    }

    List<TempModel> lt = [];
    for (var i in brands) {
      lt.add(TempModel.fromJson(i));
    }
    TempModel best = lt[0];
    for (TempModel i in lt) {
      if (best.price > i.price) best = i;
    }
    return best;
  }

  double brandToTotalPrice(brand) {
    switch (brand) {
      case AppConfig.recommended:
        return recPrice;
        break;
      case AppConfig.netmeds:
        return this.totalPrice.netmeds;
        break;
      case AppConfig.apollo:
        return this.totalPrice.apollo;
        break;
      case AppConfig.onemg:
        return this.totalPrice.i1mg;
        break;
      default:
        return 0;
    }
  }

  get getSyncBody {
    var obj = {
      "cart": [],
    };
    for (Item item in this.items) {
      obj["cart"].add(
        {
          "medicineId": item.id,
          "quantity": item.quantity.toString(),
        },
      );
    }
    return obj;
  }
}

class TempModel {
  String name;
  double price;
  TempModel({this.name, this.price});
  TempModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }
}
