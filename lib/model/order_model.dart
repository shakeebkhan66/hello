import 'package:flutter/cupertino.dart';

/// items : [{"order":0,"barcode":"string","quantity":0,"discount":0,"subtotal":0}]

class OrderModel {
  OrderModel({
      List<Items>? items,}){
    _items = items;
}

  OrderModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  List<Items>? _items;
OrderModel copyWith({  List<Items>? items,
}) => OrderModel(  items: items ?? _items,
);
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order : 0
/// barcode : "string"
/// quantity : 0
/// discount : 0
/// subtotal : 0

class Items {
  Items({
      num? order, 
      String? barcode, 
      num? quantity,
      num? discount, 
      num? subtotal,}){
    _order = order;
    _barcode = barcode;
    _quantity = quantity;
    _discount = discount;
    _subtotal = subtotal;
}

  Items.fromJson(dynamic json) {
    _order = json['order'];
    _barcode = json['barcode'];
    _quantity = json['quantity'];
    _discount = json['discount'];
    _subtotal = json['subtotal'];
  }
  num? _order;
  String? _barcode;
  num? _quantity;
  num? _discount;
  num? _subtotal;
Items copyWith({  num? order,
  String? barcode,
  num? quantity,
  num? discount,
  num? subtotal,
}) => Items(  order: order ?? _order,
  barcode: barcode ?? _barcode,
  quantity: quantity! ?? _quantity,
  discount: discount ?? _discount,
  subtotal: subtotal ?? _subtotal,
);
  num? get order => _order;
  String? get barcode => _barcode;
  num? get quantity => _quantity;
  num? get discount => _discount;
  num? get subtotal => _subtotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order'] = _order;
    map['barcode'] = _barcode;
    map['quantity'] = _quantity;
    map['discount'] = _discount;
    map['subtotal'] = _subtotal;
    return map;
  }

}