// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? name;
  String? description;
  String? price;
  String? image1;
  String? image2;
  String? image3;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image1,
    this.image2,
    this.image3,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };
}
