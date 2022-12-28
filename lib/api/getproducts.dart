import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pos/model/product_model.dart';

import '../utils/shared_screen.dart';

class GetApiProvider {

  List<ProductModel> productList = [];


  getproduct() async {
    String? mytoken = ConstantSharedPreference.preferences?.getString('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJpdGFzc3RwZG1hQGdtYWlsLmNvbSIsImV4cCI6MTY3MjEzNjg5N30.C19Ra_AV_22JO51Geu1XnOY6eiggmgLGvcR7q-9QJk4');
    final response = await http
        .get(Uri.parse('http://192.168.1.31:8080/products'), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer $mytoken",
      "Access-Control-Allow-Origin": "*"
    });
    var data = jsonDecode(response.body.toString());
    print('data is $data');
    if (response.statusCode == 200) {
    for (Map i in data) {
    print(i['name']);
    productList.add(ProductModel.fromJson(i));
    }
    return productList;
    } else {
    return productList;
    }
  }
}