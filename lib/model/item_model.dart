import 'dart:convert';

// Functions to convert between JSON and Dart objects.
ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  final bool success;
  final String message;
  final List<ItemData> data;
  final dynamic error;
  int quantity;

  ItemModel({
    required this.success,
    required this.message,
    required this.data,
    this.error,
    int? quantity,
  }) : quantity = quantity ?? 1;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<ItemData>.from(
                json["data"].map((x) => ItemData.fromJson(x))),
        error: json["error"],
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class ItemData {
  final int id;
  final int categoryId;
  final String name;
  final double price;
  final String imagePath;
  late final int quantity;
  ItemData({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imagePath,
    int? quantity,
  }) : quantity = quantity ?? 1;

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        id: json["id"] ?? 0,
        categoryId: json["categoryId"] ?? 0,
        name: json["name"] ?? "",
        price: (json["price"] ?? 0).toDouble(),
        imagePath: json["imagePath"] ?? "",
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "price": price,
        "imagePath": imagePath,
      };
}
