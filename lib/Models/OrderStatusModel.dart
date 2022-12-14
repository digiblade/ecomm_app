import 'package:ecommerce/Api/Api.dart';

class OrderStatusModel {
  String? label;
  String? remark;
  String? date;
  OrderStatusModel({this.label, this.remark, this.date});
}

getOrderStatus(payload) async {
  dynamic res = await httpPost("/getOrderStatus", payload);
  List<OrderStatusModel> statusList = [];

  for (dynamic status in res) {
    OrderStatusModel statusData = OrderStatusModel(
      label: status['status_label'],
      remark: status['status_remark'],
      date: status['updated_at'],
    );
    statusList.add(statusData);
  }
  return statusList;
}
