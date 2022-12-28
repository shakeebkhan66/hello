// import 'dart:convert';
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import '../database/db_helper.dart';
// import '../model/cart_model.dart';
// import '../model/order_model.dart';
// import '../provider/cart_provider.dart';
// import '../utils/shared_screen.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   DBHelper? dbHelper = DBHelper();
//   List<bool> tapped = [];
//   OrderModel neworder = OrderModel();
//   List<Items> cartProducts = [];
//
//
//   void order () async {
//     String? mytoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJpdGFzc3RwZG1hQGdtYWlsLmNvbSIsImV4cCI6MTY3MjEzNjg5N30.C19Ra_AV_22JO51Geu1XnOY6eiggmgLGvcR7q-9QJk4';
//     for(var i = 0; i <= hello.length; i++){
//       cartProducts.add(Items(
//         order: int.parse(order1.toString()),
//         barcode: barcode,
//         quantity: quantity,
//         discount: discount,
//         subtotal: total,
//       ));
//     }
//
//     Map data = {
//       "order": "1",
//       "barcode": 'ssssssssdd1258',
//       "quantity": "2",
//       "discount": "100",
//       "subtotal": "400"
//     };
//     String myBody = json.encode(data);
//     neworder = OrderModel(
//       items: cartProducts,
//     );
//     print(neworder.toJson());
//     try {
//       Response response = await post (
//           Uri.parse('http://192.168.1.31:8080/order'),
//           body: jsonEncode(neworder.toJson()),
//           headers: {
//             "Content-Type": "application/json",
//             "accept": "application/json",
//             "Authorization": "Bearer $mytoken",
//             "Access-Control-Allow-Origin": "*",
//        }
//       );
//           // body: jsonEncode(OrderModel.toJson()));
//       if (response.statusCode == 200){
//         var data = jsonDecode(response.body.toString());
//         print("data is $data");
//         print('order Add Successfully');
//         // print("name is $productname");
//       }else{
//         print('Failed');
//         print(response.body.toString());
//       }
//     }catch (e){
//       print(e.toString());
//     }
//
//   }
//   String? order1;
//   String? barcode;
//   var quantity;
//   var discount;
//   var total;
//   var discountx;
//
//   List hello = [];
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<CartProvider>().getData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("New Order ${neworder.toJson()}");
//     final cart = Provider.of<CartProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//         title: const Text('My Shopping Cart'),
//         actions: [
//           Badge(
//             badgeColor: Colors.green,
//             badgeContent: Consumer<CartProvider>(
//               builder: (context, value, child) {
//                 return Text(
//                   value.getCounter().toString(),
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 );
//               },
//             ),
//             position: const BadgePosition(start: 30, bottom: 30),
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.shopping_cart),
//             ),
//           ),
//           const SizedBox(
//             width: 20.0,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer<CartProvider>(
//               builder: (BuildContext context, provider, widget) {
//                 if (provider.cart.isEmpty) {
//                   return Align(
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: [
//                         const Image(
//                           image: AssetImage('assets/images/empty_cart.png'),
//                         ),
//                         const SizedBox(height: 20,),
//                         Text('Your cart is empty 😌' ,style: Theme.of(context).textTheme.headline5),
//                         const SizedBox(height: 20,),
//                         Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)
//                       ],
//                     ),
//                   );
//                 } else {
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: provider.cart.length,
//                       itemBuilder: (context, index) {
//                         order1 = provider.cart[index].productId.toString();
//                         barcode = provider.cart[index].barcode.toString();
//                         quantity = provider.cart[index].quantity;
//                         total= provider.cart[index].salePrice;
//                         discountx = (provider.cart[index].salePrice! * 0.10);
//                         discount = total! - discountx;
//                         hello = List.from(provider.cart);
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//                           child: Card(
//                             color: Colors.white,
//                             elevation: 5.0,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     SizedBox(
//                                       width: 130,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           const SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           RichText(
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 1,
//                                             text: TextSpan(
//                                                 text: 'Name: ',
//                                                 style: TextStyle(
//                                                     color: Colors.blueGrey.shade800,
//                                                     fontSize: 16.0),
//                                                 children: [
//                                                   TextSpan(
//                                                       text:
//                                                           '${provider.cart[index].productName!}\n',
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                                 ]),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           // RichText(
//                                           //   maxLines: 1,
//                                           //   text: TextSpan(
//                                           //       text: 'Sale Price: ',
//                                           //       style: TextStyle(
//                                           //           color: Colors.blueGrey.shade800,
//                                           //           fontSize: 16.0),
//                                           //       children: [
//                                           //         TextSpan(
//                                           //             text:
//                                           //                 '${provider.cart[index].salePrice!}\n',
//                                           //             style: const TextStyle(
//                                           //                 fontWeight:
//                                           //                     FontWeight.bold)),
//                                           //       ]),
//                                           // ),
//                                           RichText(
//                                             maxLines: 1,
//                                             text: TextSpan(
//                                                 text: 'Price: ' r"Rs",
//                                                 style: TextStyle(
//                                                     color: Colors.blueGrey.shade800,
//                                                     fontSize: 16.0),
//                                                 children: [
//                                                   TextSpan(
//                                                       text:
//                                                           '${provider.cart[index].salePrice!}\n',
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                                 ]),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     ValueListenableBuilder<int>(
//                                         valueListenable:
//                                           provider.cart![index].quantity!,
//                                         builder: (context, val, child) {
//                                           return PlusMinusButtons(
//                                             addQuantity: () {
//                                               cart.addQuantity(
//                                                   int.parse(provider.cart[index].productId.toString()));
//                                               dbHelper!
//                                                   .updateQuantity(Cart(
//                                                       productId: provider.cart[index].productId,
//                                                       productName: provider
//                                                           .cart[index].productName,
//                                                       salePrice: provider
//                                                           .cart[index].salePrice,
//                                                       purchasePrice: provider
//                                                           .cart[index].purchasePrice,
//                                                       quantity:
//                                                           provider.cart[index]
//                                                               .quantity!, barcode: provider.cart[index].barcode.toString(),))
//                                                   .then((value) {
//                                                 setState(() {
//                                                   cart.addTotalPrice(double.parse(
//                                                       provider
//                                                           .cart[index].purchasePrice
//                                                           .toString()));
//                                                 });
//                                               });
//                                             },
//                                             deleteQuantity: () {
//                                               cart.deleteQuantity(
//                                                   provider.cart[index].productId!);
//                                               cart.removeTotalPrice(double.parse(
//                                                   provider.cart[index].purchasePrice
//                                                       .toString()));
//                                             },
//                                             text: val.toString(),
//                                           );
//                                         }),
//                                     IconButton(
//                                         padding: const EdgeInsets.only(left: 70.0),
//                                       alignment: Alignment.centerRight,
//                                         onPressed: () {
//                                           dbHelper!.deleteCartItem(
//                                               provider.cart[index].productId!);
//                                           provider
//                                               .removeItem(provider.cart[index].productId!);
//                                           provider.removeCounter();
//                                         },
//                                         icon: Icon(
//                                           Icons.delete,
//                                           size: 25,
//                                           color: Colors.red.shade800,
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 }
//               },
//             ),
//           ),
//           Consumer<CartProvider>(
//             builder: (BuildContext context, value, Widget? child) {
//               final ValueNotifier<int?> totalPrice = ValueNotifier(null);
//               for (var element in value.cart) {
//                 totalPrice.value =
//                     ((element.salePrice! * element.quantity!) +
//                         (totalPrice.value ?? 0));
//               }
//               return Column(
//                 children: [
//                   ValueListenableBuilder<int?>(
//                       valueListenable: totalPrice,
//                       builder: (context, val, child) {
//                         return ReusableWidget(
//                             title: 'Sub-Total',
//                             value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
//                       }),
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Payment Successful'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         },
//         child: InkWell(
//           onTap: order,
//
//           child: Container(
//             color: Colors.redAccent,
//             alignment: Alignment.center,
//             height: 50.0,
//             child: const Text(
//               'Proceed to Pay',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PlusMinusButtons extends StatelessWidget {
//   final VoidCallback deleteQuantity;
//   final VoidCallback addQuantity;
//   final String text;
//   const PlusMinusButtons(
//       {Key? key,
//       required this.addQuantity,
//       required this.deleteQuantity,
//       required this.text})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove_circle),iconSize: 25,color: Colors.redAccent,),
//          Text(text),
//         IconButton(onPressed: addQuantity, icon: const Icon(Icons.add_circle),iconSize: 25,color: Colors.redAccent,),
//       ],
//     );
//   }
// }
//
// class ReusableWidget extends StatelessWidget {
//   final String title, value;
//   const ReusableWidget({Key? key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           Text(
//             value.toString(),
//             style: Theme.of(context).textTheme.subtitle2,
//           ),
//         ],
//       ),
//     );
//   }
// }
