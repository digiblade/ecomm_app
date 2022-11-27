import 'package:ecommerce/Api/Api.dart';
import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/DocumentModel.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:localstorage/localstorage.dart';

class OrderModel {
  String? address;
  String? orderId;
  String? state;
  List<CartModel>? cartProduct;
  double? total;
  OrderModel({
    this.address,
    this.cartProduct,
    this.total,
    this.orderId,
    this.state,
  });
}

placeOrder(OrderModel cartDetail) async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  List productList = [];
  double total = 0;
  for (CartModel product in cartDetail.cartProduct!) {
    Map<String, dynamic> prod = {
      "product_id": product.product!.productId!,
      "product_count": product.count,
      "product_price": product.product!.productPrice,
    };
    total += (double.parse(product.product!.productPrice!) * product.count!);
    productList.add(prod);
  }
  dynamic res = await httpPost(
    "/order",
    {
      "userid": email,
      "products": productList,
      "total": total,
      "address": cartDetail.address,
    },
    onSuccess: "Order Placed",
    showMsg: true,
  );
  return res;
}

Future<List<OrderModel>> getOrder() async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  List<OrderModel> orderList = [];

  dynamic res = await httpPost(
    "/order/get",
    {
      "userid": email,
    },
  );
  for (dynamic order in res) {
    List<CartModel> cartData = [];
    for (dynamic section in order['section']) {
      dynamic product = section['product'];
      List<DocumentModel> docs = getDocuments(product['documents']);

      ProductModel prod = ProductModel(
        docList: docs,
        productId: product['product_id'],
        productName: product['product_name'],
        productDescription: product['product_description'],
        productPrice: product['product_mrp'],
        offerPrice: product['product_price'],
      );
      CartModel cart = CartModel(
        count: int.parse(section['product_count']),
        product: prod,
      );
      cartData.add(cart);
    }
    OrderModel ord = OrderModel(
      orderId: order['order_id'],
      state: order['order_status'],
      address: order['order_address'],
      total: double.parse(order['order_total']),
      cartProduct: cartData,
    );
    orderList.add(ord);
  }

  return orderList;
}
