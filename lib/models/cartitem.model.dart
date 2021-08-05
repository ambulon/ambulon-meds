import 'cartprice.model.dart';

class Item {
  String name;
  int quantity;
  Price price;
  String id;
  String image;

  Item({this.name, this.quantity, this.price, this.id, this.image});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    id = json['medicineId'] ?? "";
    image = json['image'] ??
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=715&q=80';
  }
}
