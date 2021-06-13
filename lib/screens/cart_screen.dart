import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evaluation_task/components/drawerForApp.dart';
import 'package:evaluation_task/user_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../user_product_details.dart';

class CartScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String id = 'cartScreen';
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Product deleted from the cart',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black45,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: Center(
              child: Text(
                Provider.of<Users>(context).productCount.toString(),
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
      body: Consumer<Users>(builder: (context, productDetails, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('user')
                .doc(user.uid)
                .collection('cart')
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

              var cartList = snapshot.data.docs;

              for (var i in cartList) {
                productDetails.addProduct(
                    name: i.get('name'),
                    image: i.get('image'),
                    price: i.get('price'),
                    type: i.get('type'));
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final product = productDetails.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: kContainerCircularBorders,
                        color: kContainerButtonColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: 150,
                            padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   borderRadius: kContainerCircularBorders,
                            //   color: kContainerButtonColor,
                            // ),
                            child: ClipRRect(
                              borderRadius: kContainerCircularBorders,
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    'Name: ${product.name.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Subscription: ${product.type}',
                                      style: TextStyle(fontSize: 16.5)),
                                  Text('Price: ${product.price}/-',
                                      style: TextStyle(fontSize: 16.5)),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: () {
                                productDetails.deleteProduct(product);
                                Scaffold.of(context).showSnackBar(snackBar);
                              })
                        ],
                      ),
                    ),
                  );
                },
                itemCount: productDetails.productCount,
              );
            });
      }),
    );
  }
}
