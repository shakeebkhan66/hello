class ProductModel {
  ProductModel({
    String? productName,
    String? barcode,
    num? purchasePrice,
    int? id,
    num? productQuantity,
    required num salePrice,}){
    _productName = productName;
    _barcode = barcode;
    _purchasePrice = purchasePrice;
    _id = id;
    _productQuantity = productQuantity;
    _salePrice = salePrice;
  }

  ProductModel.fromJson(dynamic json) {
    _productName = json['product_name'];
    _barcode = json['barcode'];
    _purchasePrice = json['purchase_price'];
    _id = json['id'];
    _productQuantity = json['product_quantity'];
    _salePrice = json['sale_price'];
  }
  String? _productName;
  String? _barcode;
  num? _purchasePrice;
  int? _id;
  num? _productQuantity;
  late num _salePrice;
  ProductModel copyWith({  String? productName,
    String? barcode,
    num? purchasePrice,
    int? id,
    num? productQuantity,
    required num salePrice,
  }) => ProductModel(  productName: productName ?? _productName,
    barcode: barcode ?? _barcode,
    purchasePrice: purchasePrice ?? _purchasePrice,
    id: id ?? _id,
    productQuantity: productQuantity ?? _productQuantity,
    salePrice: salePrice ?? _salePrice,
  );
  String? get productName => _productName;
  String? get barcode => _barcode;
  num? get purchasePrice => _purchasePrice;
  int? get id => _id;
  num? get productQuantity => _productQuantity;
  num get salePrice => _salePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['barcode'] = _barcode;
    map['purchase_price'] = _purchasePrice;
    map['id'] = _id;
    map['product_quantity'] = _productQuantity;
    map['sale_price'] = _salePrice;
    return map;
  }

}