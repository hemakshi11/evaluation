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
      body: Container(
        child: Column(
          children: <Widget>[
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

                List<ReusableCards> productCards = [];

                for (var product in products) {
                  final cards = ReusableCards(product: product.data());
                  productCards.add(cards);
                }
                return Expanded(
                  child: ListView(
                    children: productCards,
                  ),
                );
              },
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
