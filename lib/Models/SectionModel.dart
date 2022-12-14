import "../Api/Api.dart";
import 'ProductModel.dart';
import 'DocumentModel.dart';

class SectionModel {
  String? sectionName;
  List<ProductModel> productList;
  SectionModel({this.sectionName, this.productList = const []});
}

Future<List<SectionModel>> getAllSection() async {
  dynamic res = await httpGet("/product-section");
  List<SectionModel> sectionList = [];
  if (res != false) {
    for (dynamic sectionRes in res) {
      String sectionLabel = sectionRes['section_label'] ?? "";
      dynamic productList = sectionRes['products'];
      List<ProductModel> prodList = [];
      for (dynamic product in productList) {
        dynamic prodDetails = product['product'] ?? {};
        List<DocumentModel> docList =
            getDocuments(prodDetails['documents'] ?? []);
        ProductModel prod = ProductModel(
          productId: prodDetails['product_id'],
          productName: prodDetails['product_name'],
          productDescription: prodDetails['product_description'],
          productPrice: prodDetails['product_mrp'],
          offerPrice: prodDetails['product_price'],
          docList: docList,
        );

        prodList.add(prod);
      }
      SectionModel section = SectionModel(
        productList: prodList,
        sectionName: sectionLabel,
      );
      sectionList.add(section);
    }
  }
  return sectionList;
}

Future<List<SectionModel>> getAllSectionById(String id) async {
  dynamic res = await httpGet("/getSection/$id");
  List<SectionModel> sectionList = [];
  if (res != false) {
    for (dynamic sectionRes in res) {
      String sectionLabel = sectionRes['section_label'] ?? "";
      dynamic productList = sectionRes['products'];
      List<ProductModel> prodList = [];
      for (dynamic product in productList) {
        dynamic prodDetails = product['product'];
        List<DocumentModel> docList =
            getDocuments(prodDetails['documents'] ?? []);
        ProductModel prod = ProductModel(
          productId: prodDetails['product_id'],
          productName: prodDetails['product_name'],
          productDescription: prodDetails['product_description'],
          productPrice: prodDetails['product_mrp'],
          offerPrice: prodDetails['product_price'],
          docList: docList,
        );

        prodList.add(prod);
      }
      SectionModel section = SectionModel(
        productList: prodList,
        sectionName: sectionLabel,
      );
      sectionList.add(section);
    }
  }
  return sectionList;
}

Future<List<ProductModel>> getAllProductByCategory(String catid) async {
  dynamic res = await httpGet("/cat-product/$catid");
  List<ProductModel> prodList = [];
  if (res != false) {
    for (dynamic product in res) {
      dynamic prodDetails = product;
      List<DocumentModel> docList =
          getDocuments(prodDetails['documents'] ?? []);
      ProductModel prod = ProductModel(
        productId: prodDetails['product_id'],
        productName: prodDetails['product_name'],
        productDescription: prodDetails['product_description'],
        productPrice: prodDetails['product_mrp'],
        offerPrice: prodDetails['product_price'],
        docList: docList,
      );

      prodList.add(prod);
    }
  }

  return prodList;
}
