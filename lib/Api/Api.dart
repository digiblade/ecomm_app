import 'dart:developer';

import 'package:dio/dio.dart';

const appURL = "http://10.0.2.2:8000/api";
const imageURL = "http://10.0.2.2:8000/documents/";
httpGet(String url) async {
  Dio dio = Dio();
  dynamic res = await dio.get(appURL + url);
  if (res.statusCode! >= 200 && res.statusCode! < 300) {
    return res.data;
  } else {
    return false;
  }
}

httpPost(String url, Map<String, dynamic> payload) async {
  Dio dio = Dio();
  FormData formData = FormData.fromMap(payload);
  try {
    Response res = await dio.post(appURL + url, data: formData);

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      return res.data;
    } else {
      return false;
    }
  } catch (e) {
    print("error $e");
  }
}
