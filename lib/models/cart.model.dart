class CartModel {
  List<SingleCartItem> list;

  CartModel(this.list);

  CartModel.fromJson(Map json) {
    List<SingleCartItem> tempList = [];
    CartModel(
      this.list = tempList,
    );
  }
}

class SingleCartItem {}
