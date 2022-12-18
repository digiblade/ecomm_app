// ignore: file_names
import 'document_model.dart';

class ProductModel {
  String? productName;
  String? productId;
  String? productDescription;
  String? offerPrice;
  String? productPrice;
  String? productImage;
  List<DocumentModel> docList;
  ProductModel({
    this.productName,
    this.productId,
    this.productDescription,
    this.offerPrice,
    this.productPrice,
    this.docList = const [],
  });
}
