import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

httpPost(
  String url,
  Map<String, dynamic> payload, {
  String onSuccess = "",
  String onFail = "",
  String onError = "Something went wrong",
  bool showMsg = false,
}) async {
  Dio dio = Dio();
  FormData formData = FormData.fromMap(payload);
  try {
    Response res = await dio.post(appURL + url, data: formData);

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      if (showMsg) {
        Fluttertoast.showToast(
          msg: onSuccess,
          backgroundColor: Colors.green,
        );
      }
      return res.data;
    } else {
      if (showMsg) {
        Fluttertoast.showToast(
          msg: onFail,
          backgroundColor: Colors.red,
        );
      }
      return false;
    }
  } catch (e) {
    if (showMsg) {
      Fluttertoast.showToast(
        msg: onError,
        backgroundColor: Colors.yellow,
      );
    }
    print("error $e");
  }
}
