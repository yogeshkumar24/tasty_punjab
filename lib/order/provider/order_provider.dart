import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tasty_punjab/shared/constants.dart';

import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  double totalItemPrice = 0;
  double totalPrice = 0;

  calculateItemPrice(countItem, price, bool isIncrease) {
    if (isIncrease) {
      totalItemPrice = totalItemPrice + double.parse(price);
    } else {
      totalItemPrice = totalItemPrice - double.parse(price);
    }
    totalPrice = totalItemPrice + DELIVERY_CHARGE + TAX;
    notifyListeners();
  }

  calculateTotalPrice(countItem, price) {
    totalItemPrice = totalPrice + countItem * double.parse(price);
    totalPrice = totalItemPrice + DELIVERY_CHARGE + TAX;
    notifyListeners();
  }

  Future<OrderItemList> getItemList() async {
    Response response = await http.get(Uri.parse(API));
    print(response.statusCode);
    OrderItemList list = OrderItemList.fromJson(json.decode(response.body));
    print("name is +......${list.getDetail[1].name}");
    return list;
  }
}
