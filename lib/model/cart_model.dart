import 'package:flutter/material.dart';

class Cart {
  final int? productId;
  final String? productName;
  final int? salePrice;
  final int? purchasePrice;
  final ValueNotifier<int>? quantity;

  Cart(
      {
        required this.productId,
        required this.productName,
        required this.salePrice,
        required this.purchasePrice,
        required this.quantity,});

  Cart.fromMap(Map<dynamic, dynamic> data)
      :
        productId = data['productId'],
        productName = data['productName'],
        salePrice = data['salePrice'],
        purchasePrice = data['purchasePrice'],
        quantity = ValueNotifier(data['quantity']);

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'salePrice': salePrice,
      'purchasePrice': purchasePrice,
      'quantity': quantity?.value,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity!.value,
    };
  }
}
