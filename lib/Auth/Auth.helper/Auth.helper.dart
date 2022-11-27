import '../../Api/Api.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

registerClient(Map<String, dynamic> payload) async {
  dynamic data = await httpPost("/client/register", payload);
  if (data != false) {
    return data;
  } else {
    return false;
  }
}

loginClient(Map<String, dynamic> payload) async {
  dynamic data = await httpPost("/client/checkUser", payload);
  if (data['response'] != false) {
    LocalStorage storage = LocalStorage("auth.json");
    storage.setItem("userDetails", data);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLoggedIn", true);
    return true;
  } else {
    return false;
  }
}

logoutClient() async {
  // if (data['response'] != false) {
  LocalStorage storage = LocalStorage("auth.json");
  storage.setItem("userDetails", {});
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("isLoggedIn", false);

  return true;
  // } else {
  //   return false;
  // }
}
