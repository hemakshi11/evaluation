// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constants.dart';
// import '../user_product_details.dart';
//
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// class FinalOrder extends StatelessWidget {
//   static String id = 'finalOrderScreen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Consumer<Users>(builder: (context, productDetails, child) {
//             return StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('user')
//                     .doc(user.uid)
//                     .collection('cart')
//                     .orderBy('timeStamp')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Scaffold(
//                       body: Center(
//                         child: Text('ERROR: ${snapshot.error}'),
//                       ),
//                     );
//                   }
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         backgroundColor: Colors.teal,
//                       ),
//                     );
//                   }
//
//                   var cartList = snapshot.data.docs;
//
//                   for (var i in cartList) {
//                     productDetails.addProduct(
//                         name: i.get('name'),
//                         image: i.get('image'),
//                         price: i.get('price'),
//                         type: i.get('type'));
//                   }
//
//                   return Expanded(
//                     child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         final product = productDetails.products[index];
//                         return Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: kContainerCircularBorders,
//                               color: kContainerButtonColor,
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Container(
//                                   height: 150,
//                                   width: 150,
//                                   padding: EdgeInsets.all(10),
//                                   // decoration: BoxDecoration(
//                                   //   borderRadius: kContainerCircularBorders,
//                                   //   color: kContainerButtonColor,
//                                   // ),
//                                   child: ClipRRect(
//                                     borderRadius: kContainerCircularBorders,
//                                     child: Image.network(
//                                       product.image,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     height: 150,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: <Widget>[
//                                         Text(
//                                           'Name: ${product.name.toUpperCase()}',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text('Subscription: ${product.type}',
//                                             style: TextStyle(fontSize: 16.5)),
//                                         Text('Price: ${product.price}/-',
//                                             style: TextStyle(fontSize: 16.5)),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 // IconButton(
//                                 //     icon: Icon(Icons.clear_rounded),
//                                 //     onPressed: () {
//                                 //       productDetails.deleteProduct(product);
//                                 //       Scaffold.of(context).showSnackBar(snackBar);
//                                 //     })
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       itemCount: productDetails.productCount,
//                     ),
//                   );
//                 });
//           }),
//           // Expanded(child: child)
//         ],
//       ),
//     );
//   }
// }
