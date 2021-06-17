import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evaluation_task/components/drawerForApp.dart';
import 'package:evaluation_task/screens/cart_screen.dart';
import 'package:evaluation_task/components/reusable_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evaluation_task/user_product_details.dart';
import '../product_data.dart';
import '../user_product_details.dart';

// bool isThere = false;

class ProductScreen extends StatelessWidget {
  static String id = 'productScreen';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: Center(
              child: Text(
                Provider.of<Users>(context).products.length.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
            ),
          ),
        ],
      ),
      drawer: DrawerForApp(),
      body: Container(
        child: Column(
          children: <Widget>[
            Consumer<Users>(
              builder: (context, productDetails, child) =>
                  StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('products')
                    .orderBy('timeStamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('ERROR: ${snapshot.error}'),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }

                  final products = snapshot.data.docs;

                  // List<ReusableCards> productCards = [];
                  List<ReusableCards> cards = [];
                  List toBeRemoved = [];
                  //var cartItem;
                  if (products.isNotEmpty) {
                    for (var product in products) {
                      if (productDetails.products.isNotEmpty) {
                        for (var cartItem in productDetails.products) {
                          if (cartItem.name == product.get('name')) {
                            cards.add(
                              ReusableCards(
                                  product: product.data(),
                                  isInCart: true,
                                  sub: cartItem.type),
                            );
                            toBeRemoved.add(product);
                            break;
                          }
                        }

                        // if (cards.contains(ReusableCards(
                        //     product: product.data(),
                        //     isInCart: true,
                        //     sub: cartItem.type),
                        // ))) {
                        //   cards.add(
                        //     ReusableCards(
                        //         isInCart: false, product: product.data()),
                        //   );
                        // }
                      }
                      //   else {
                      //     cards.add(
                      //       ReusableCards(
                      //           isInCart: false,
                      //           //sub: cartItem.type,
                      //           product: product.data()),
                      //     );
                      //   }
                    }
                    if (toBeRemoved.isNotEmpty) {
                      toBeRemoved.forEach((elem) {
                        products.remove(elem);
                      });
                    }
                    if (products.isNotEmpty) {
                      products.forEach((element) {
                        cards.add(
                          ReusableCards(
                              isInCart: false,
                              //sub: cartItem.type,
                              product: element.data()),
                        );
                      });
                    }
                  }
                  return Expanded(
                    child: ListView(
                      // itemBuilder: (context, index)=>ReusableCards(product: products[index].data(),)
                      // itemCount: products.length,
                      children: cards,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// if (snapshot.connectionState == ConnectionState.done) {
//   return ListView(
//     children: snapshot.data.docs.map((document) {
//       return Container(
//         child: Image.network("${document.data()['image']}"),
//       );
//     }).toList(),
//   );
// }
