import "../Api/Api.dart";
import "../Util/consturl.dart";

class CategoryModel {
  String? categoryName;
  String? categoryImage;
  String? categoryId;
  CategoryModel({this.categoryName, this.categoryImage, this.categoryId});
}

Future<List<CategoryModel>> getAllCategory() async {
  dynamic res = await httpGet("/category");
  List<CategoryModel> category = [];
  if (res != false) {
    for (dynamic categoryRes in res) {
      if (categoryRes['documents'].length > 0) {
        String imageLabel = categoryRes['documents'][0]['document_label'] ?? "";
        String imageName = categoryRes['documents'][0]['document_path'] ?? "";
        CategoryModel categoryElement = CategoryModel(
          categoryName: categoryRes['category_name'],
          categoryImage: '$imageURL$imageLabel/$imageName',
          categoryId: '$categoryRes["category_id"]',
        );
        category.add(categoryElement);
      } else {
        CategoryModel categoryElement = CategoryModel(
          categoryName: categoryRes['category_name'],
          categoryImage: '',
          categoryId: '$categoryRes["category_id"]',
        );
        category.add(categoryElement);
      }
    }
  }
  return category;
}
