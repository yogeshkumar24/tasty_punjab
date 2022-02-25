class OrderItemList {
  List<OrderInfo> getDetail;

  OrderItemList({this.getDetail});

  OrderItemList.fromJson(Map<String, dynamic> json) {
    if (json['get_detail'] != null) {
      getDetail = <OrderInfo>[];
      json['get_detail'].forEach((v) {
        getDetail.add(OrderInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.getDetail != null) {
      data['get_detail'] = this.getDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderInfo {
  String id;
  String price;
  String name;
  String detail;
  String media;

  OrderInfo({this.id, this.price, this.name, this.detail, this.media});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    detail = json['detail'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['media'] = this.media;
    return data;
  }
}
