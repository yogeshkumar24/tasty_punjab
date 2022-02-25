import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty_punjab/map/page/map_page.dart';
import 'package:tasty_punjab/order/provider/order_provider.dart';
import 'package:tasty_punjab/order/widgets/order_item_widget.dart';

import '../model/order_model.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderProvider provider;
  int selectedIndex;
  @override
  void initState() {
    provider = OrderProvider();
    getItems();
    super.initState();
  }

  bool isLoading = false;
  OrderItemList itemlist = OrderItemList();

  getItems() async {
    setState(() {
      isLoading = true;
    });
    provider.getItemList().then((value) {
      itemlist = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderProvider>(
        create: (ctx) => provider,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Check"),
            centerTitle: true,
            backgroundColor: Colors.orangeAccent,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView.builder(
                              itemCount: itemlist.getDetail.length,
                              itemBuilder: (context, index) {
                                return OrderItemWidget(
                                  key: UniqueKey(),
                                  itemlist: itemlist.getDetail[index],
                                );
                              }),
                        ),
                        Consumer<OrderProvider>(
                            builder: (context, provider, child) {
                          return Column(
                            children: [
                              horizontalLine(),
                              SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Bill Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              buildRow("Item total", provider.totalItemPrice),
                              buildRow(
                                "Delivery partner fee for 3.8 km",
                                "2.00",
                              ),
                              buildRow(
                                "Taxes and Charges",
                                "2.00",
                              ),
                              horizontalLine(),
                              buildRow(
                                  "Total Price",
                                  provider.totalItemPrice != 0
                                      ? provider.totalPrice
                                      : 0),
                              horizontalLine(),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 100),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MapPage()));
                                      },
                                      child: const Text(
                                        'Place Your Order',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        })
                      ],
                    ),
            ),
          ),
        ));
  }

  Container horizontalLine() {
    return Container(
      color: Colors.black,
      height: 1,
    );
  }

  Widget buildRow(text1, text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1),
          Text('${text2}'),
        ],
      ),
    );
  }
}
