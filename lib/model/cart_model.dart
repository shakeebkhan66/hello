import 'package:flutter/material.dart';

class Cart {
  final int? productId;
  final String? productName;
  final String? barcode;
  final int? salePrice;
  final int? purchasePrice;
  late final int? quantity;
  // final ValueNotifier<int>? quantity;

  Cart(
      {
        required this.productId,
        required this.productName,
        required this.barcode,
        required this.salePrice,
        required this.purchasePrice,
        required this.quantity,
      });

  Cart.fromMap(Map<dynamic, dynamic> data)
      :
        productId = data['productId'],
        productName = data['productName'],
        barcode = data['barcode'],
        salePrice = data['salePrice'],
        purchasePrice = data['purchasePrice'],
        quantity = data["quantity"];
        // quantity = ValueNotifier(data['quantity']);

  Map<String, dynamic?> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'barcode': barcode,
      'salePrice': salePrice,
      'purchasePrice': purchasePrice,
      'quantity' : quantity,
      // 'quantity': quantity?.value,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity' : quantity,
      // 'quantity': quantity!.value,
    };
  }
}
