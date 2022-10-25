import 'package:ecommerce/Models/ProductModel.dart';
import 'package:localstorage/localstorage.dart';

class CartModel {
  ProductModel? product;
  int? count;
  CartModel({this.product, this.count});
  CartModel.fromJson(Map<String, dynamic> json)
      : product = ProductModel(
          productId: json['product_id'],
          productDescription: json['product_description'],
          productName: json['product_name'],
          offerPrice: json['product_price'],
          productPrice: json['product_mrp'],
        ),
        count = json['count'] != null ? json['count'] + 1 : 1;
  Map<String, dynamic> toJson() => {
        'product_id': product!.productId,
        'product_description': product!.productDescription,
        'product_name': product!.productName,
        'product_price': product!.offerPrice,
        'product_mrp': product!.productPrice,
        'count': count ?? 1,
      };
}

addToCart(ProductModel product) {
  try {
    CartModel cart = CartModel(product: product);
    Map<String, dynamic> cartProductJSON = cart.toJson();
    final storage = LocalStorage('cartdata.json');
    Map<String, dynamic> cartJSON = storage.getItem("cartJSON") ?? {};
    if (cartJSON['productList'] != null && cartJSON['productList'].length > 0) {
      bool inserted = false;
      for (dynamic prod in cartJSON['productList']) {
        if (!inserted &&
            cartJSON['productList'][prod]['product_id'] ==
                cartProductJSON['product_id']) {
          cartJSON['productList'][prod]['count'] += 1;
          break;
        }
      }
      if (!inserted) {
        cartJSON['productList'].add(cartProductJSON);
      }
    } else {
      cartJSON['productList'] = [cartProductJSON];
    }
    storage.setItem("cartJSON", cartJSON);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
