import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/order_model.dart';
import '../provider/order_provider.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({
    Key key,
    @required this.itemlist,
  }) : super(key: key);

  final OrderInfo itemlist;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget>
    with AutomaticKeepAliveClientMixin {
  var countItem = 0;
  OrderProvider provider;

  @override
  bool get wantKeepAlive => true;

  increaseItem(String price) {
    setState(() {
      countItem = countItem + 1;
      provider.calculateItemPrice(countItem, price, true);
    });
  }

  decreaseItem(String price) {
    setState(() {
      countItem = countItem - 1;
      provider.calculateItemPrice(countItem, price, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<OrderProvider>(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      child: Image.network('${widget.itemlist.media}',
                          fit: BoxFit.cover, height: 80.0, width: 80.0)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.itemlist.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                      ),
                      Text(
                        '${widget.itemlist.detail}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                      ),
                    ]),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            if (countItem != 0) {
                              decreaseItem(widget.itemlist.price);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('-'),
                          )),
                      Text('${countItem}'),
                      InkWell(
                          onTap: () {
                            increaseItem(widget.itemlist.price);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('+'),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 50,
                  child: Text('${widget.itemlist.price}'),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }
}
