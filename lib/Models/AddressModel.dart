import 'package:ecommerce/Api/Api.dart';
import 'package:localstorage/localstorage.dart';

class AddressModel {
  String? username;
  String? address;
  String? pincode;
  String? uid;
  String? contact;
  bool? isDefault;
  String? addressUid;
  AddressModel({
    this.address,
    this.contact,
    this.pincode,
    this.uid,
    this.username,
    this.isDefault = false,
    this.addressUid,
  });
}

addAddress(AddressModel userdata) async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  await httpPost(
    "/client/addUserAddress",
    {
      "username": userdata.username,
      "address": userdata.address,
      "contact": userdata.contact,
      "pincode": userdata.pincode,
      "uid": email,
    },
    onSuccess: "Address added",
    showMsg: true,
  );
  return true;
}

updateAddress(AddressModel userdata) async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  await httpPost(
    "/client/editUserAddress",
    {
      "username": userdata.username,
      "address": userdata.address,
      "contact": userdata.contact,
      "pincode": userdata.pincode,
      "uid": email,
      "addressid": userdata.addressUid,
    },
    onSuccess: "Address added",
    showMsg: true,
  );
  return true;
}

deleteAddress(AddressModel userdata) async {
  await httpPost(
    "/client/deleteUserAddress",
    {
      "addressid": userdata.addressUid,
    },
    onSuccess: "Address deleted",
    showMsg: true,
  );
  return true;
}

Future<List<AddressModel>> getAddress() async {
  LocalStorage storage = LocalStorage("auth.json");
  dynamic data = storage.getItem("userDetails");
  String email = data['email'];
  List<AddressModel> addressList = [];

  dynamic res = await httpPost(
    "/client/getUserAddress",
    {
      "uid": email,
    },
  );
  for (dynamic add in res) {
    AddressModel address = AddressModel(
      uid: add['address_uid'],
      address: add['address_detail'],
      contact: add['address_contact'],
      pincode: add['address_pincode'],
      username: add['address_username'],
      addressUid: add['address_id'],
    );
    addressList.add(address);
  }
  return addressList;
}
