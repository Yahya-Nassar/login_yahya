import 'dart:convert';
import 'package:login_yahya/model/item_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  double subTotal;
  double discount;
  double vat;
  double total;
  List<ItemData> items;

  OrderModel({
    this.subTotal = 0,
    this.discount = 0,
    this.vat = 0,
    this.total = 0,
    List<ItemData>? items,
  }) : items = items ?? [];

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      subTotal: json["subTotal"] ?? 0,
      discount: json["discount"] ?? 0,
      vat: json["vat"] ?? 0,
      total: json["total"] ?? 0,
      items: json["items"] == null
          ? []
          : List<ItemData>.from(json["items"].map((x) => ItemData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "discount": discount,
        "vat": vat,
        "total": total,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
