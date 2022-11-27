import 'package:ecommerce/Api/Api.dart';
import 'package:ecommerce/Models/DocumentModel.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // CartModel cart = CartModel(product: product);
    // Map<String, dynamic> cartProductJSON = cart.toJson();
    // final storage = LocalStorage('cartdata.json');
    // Map<String, dynamic> cartJSON = storage.getItem("cartJSON") ?? {};
    // if (cartJSON['productList'] != null && cartJSON['productList'].length > 0) {
    //   bool inserted = false;
    //   for (dynamic prod in cartJSON['productList']) {
    //     if (!inserted &&
    //         cartJSON['productList'][prod]['product_id'] ==
    //             cartProductJSON['product_id']) {
    //       cartJSON['productList'][prod]['count'] += 1;
    //       break;
    //     }
    //   }
    //   if (!inserted) {
    //     cartJSON['productList'].add(cartProductJSON);
    //   }
    // } else {
    //   cartJSON['productList'] = [cartProductJSON];
    // }
    // storage.setItem("cartJSON", cartJSON);
    addToCartByAPI(product);
    return true;
  } catch (e) {
    return false;
  }
}

getCart() {
  List<CartModel> cartList = [];
  try {
    final storage = LocalStorage('cartdata.json');
    Map<String, dynamic> cartJSON = storage.getItem("cartJSON") ?? {};
    return true;
  } catch (e) {
    return false;
  }
}

// api

addToCartByAPI(ProductModel product, {int count = 1}) async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  httpPost(
    "/addCartProduct",
    {"email": email, "id": product.productId, "count": count},
    onSuccess: "Add to cart",
    showMsg: true,
  );
}

removeToCartByAPI(ProductModel product) async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  httpPost(
    "/addCartProduct",
    {"email": email, "id": product.productId, "remove": true},
    onSuccess: "Product Removed",
    showMsg: true,
  );
}

Future<List<CartModel>> getCartByAPI() async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  dynamic res = await httpPost("/getCartProduct", {
    "email": email,
  });
  List<CartModel> cartList = [];
  for (dynamic cartData in res) {
    List<DocumentModel> docList = [];
    for (dynamic document in cartData['product']['documents']) {
      DocumentModel doc = DocumentModel(
        documentId: document['document_id'],
        documentLabel: document['document_label'],
        documentName: document['document_path'],
        parentId: document['document_parentid'],
      );
      docList.add(doc);
    }
    ProductModel prod = ProductModel(
      productId: cartData['product']['product_id'],
      productName: cartData['product']['product_name'],
      productDescription: cartData['product']['product_description'],
      productPrice: cartData['product']['product_mrp'],
      offerPrice: cartData['product']['product_price'],
      docList: docList,
    );
    CartModel cart = CartModel(
      count: int.parse(cartData['cart_productcount']),
      product: prod,
    );
    cartList.add(cart);
  }
  return cartList;
}
