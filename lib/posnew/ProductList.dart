import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:pos/posnew/cartScreen.dart';
import 'package:pos/posnew/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pos/posnew/cartModel.dart';
import 'package:pos/posnew/dbHelper.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  // TODO Database Instance
  DBHelper? dbHelper = DBHelper();

  // TODO ProductModel (ProductList)
  List<ProductModel> productList = [];

  // TODO Token For Authorization
  String? mytoken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJpdGFzc"
      "3RwZG1hQGdtYWlsLmNvbSIsImV4cCI6MTY3MjA2MjAwN30.fJ5Pwg3GxBT7TEekRw8hrn2"
      "zlAnXrCiuqb3Xof_C-2Q";

  List<String> productName = ['Mango' , 'Orange' , 'Grapes' , 'Banana' , 'Chery' , 'Peach','Mixed Fruit Basket',] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'Dozen' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612' ,
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612' ,
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612' ,
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612' ,
  ];


  // TODO Fetch Product API
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


  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Product List'),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: Badge(
                showBadge: true,
                badgeColor: Colors.green,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value , child){
                    return Text(value.getCounter().toString(),style: const TextStyle(color: Colors.white));
                  },
                ),
                animationType: BadgeAnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index){
                  return Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0.2),
                          blurRadius: 10,
                        )
                      ]
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(productImage[index].toString()),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productName[index].toString() ,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(productUnit[index].toString() +" "+r"$"+ productPrice[index].toString() ,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: (){
                                            print(index);
                                            print(index);
                                            print(productName[index].toString());
                                            print( productPrice[index].toString());
                                            print( productPrice[index]);
                                            print('1');
                                            print(productUnit[index].toString());
                                            print(productImage[index].toString());

                                            dbHelper!.insert(
                                                Cart(
                                                    id: index,
                                                    productId: index.toString(),
                                                    productName: productName[index].toString(),
                                                    initialPrice: productPrice[index],
                                                    productPrice: productPrice[index],
                                                    quantity: 1,
                                                    unitTag: productUnit[index].toString(),
                                                    image: productImage[index].toString())
                                            ).then((value){

                                              cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                              cart.addCounter();

                                              final snackBar =  SnackBar(backgroundColor: Colors.green,content: Text('Product is added to cart'), duration: Duration(seconds: 1),);

                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            }).onError((error, stackTrace){
                                              print("error"+error.toString());
                                              final snackBar = SnackBar(backgroundColor: Colors.red ,content: Text('Product is already added in cart'), duration: Duration(seconds: 1));

                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            });
                                          },
                                          child:  Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: const Center(
                                              child:  Text('Add to cart' , style: TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),

        ],
      ),
    );
  }
}
