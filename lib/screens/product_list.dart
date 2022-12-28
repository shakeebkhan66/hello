import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:pos/api/getproducts.dart';
import 'package:provider/provider.dart';
import '../database/db_helper.dart';
import '../model/cart_model.dart';
import '../model/item_model.dart';
import '../model/product_model.dart';
import '../provider/cart_provider.dart';
import '../utils/shared_screen.dart';
import 'cart_screen.dart';
import 'package:http/http.dart' as http;


class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();
  GetApiProvider? getApiProvider;

  List<Item> products = [
    Item(
        name: 'Apple', unit: 'Kg', price: 20, image: 'assets/images/apple.png'),
    Item(
        name: 'Mango',
        unit: 'Doz',
        price: 30,
        image: 'assets/images/mango.png'),
    Item(
        name: 'Banana',
        unit: 'Doz',
        price: 10,
        image: 'assets/images/banana.png'),
    Item(
        name: 'Grapes',
        unit: 'Kg',
        price: 8,
        image: 'assets/images/grapes.png'),
    Item(
        name: 'Water Melon',
        unit: 'Kg',
        price: 25,
        image: 'assets/images/watermelon.png'),
    Item(name: 'Kiwi', unit: 'Pc', price: 40, image: 'assets/images/kiwi.png'),
    Item(
        name: 'Orange',
        unit: 'Doz',
        price: 15,
        image: 'assets/images/orange.png'),
    Item(name: 'Peach', unit: 'Pc', price: 8, image: 'assets/images/peach.png'),
    Item(
        name: 'Strawberry',
        unit: 'Box',
        price: 12,
        image: 'assets/images/strawberry.png'),
    Item(
        name: 'Fruit Basket',
        unit: 'Kg',
        price: 55,
        image: 'assets/images/fruitBasket.png'),
  ];


  List<ProductModel> productList = [];
  String? mytoken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJpdGFzc"
      "3RwZG1hQGdtYWlsLmNvbSIsImV4cCI6MTY3MjA2MjAwN30.fJ5Pwg3GxBT7TEekRw8hrn2"
      "zlAnXrCiuqb3Xof_C-2Q";

  getproduct() async {

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproduct();
  }



  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    print("Hello $productList");
    // void saveData(int index) {
    //   dbHelper
    //       .insert(
    //     Cart(
    //       id: index,
    //       productId: index.toString(),
    //       productName: products[index].name,
    //       initialPrice: products[index].price,
    //       productPrice: products[index].price,
    //       quantity: ValueNotifier(1),
    //       unitTag: products[index].unit,
    //       image: products[index].image,
    //     ),
    //   )
    //       .then((value) {
    //     cart.addTotalPrice(products[index].price.toDouble());
    //     cart.addCounter();
    //     print('Product Added to cart');
    //   }).onError((error, stackTrace) {
    //     print(error.toString());
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          onPressed:
            getproduct,
          icon: const Icon(Icons.ac_unit_rounded),
        ),
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          Badge(
            badgeColor: Colors.green,
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          shrinkWrap: true,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                      '${productList[index].productName.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          const SizedBox(
                            height: 05,
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Price: ' r"Rs ",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text:
                                      '${productList[index].salePrice.toString()}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent),
                        onPressed: () {
                          dbHelper
                              .insert(
                            Cart(
                              productId: productList[index].id,
                              barcode: productList[index].barcode,
                              productName: productList[index].productName,
                              salePrice: productList[index].salePrice.toInt(),
                              purchasePrice: productList[index].purchasePrice?.toInt(),
                              quantity: productList[index].productQuantity?.toInt(),
                              // quantity: ValueNotifier(1),
                            ),
                          )
                              .then((value) {
                            cart.addTotalPrice(products[index].price.toDouble());
                            cart.addCounter();
                            print('Product Added to cart');
                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        },
                        child: const Text('Add to Cart')),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
