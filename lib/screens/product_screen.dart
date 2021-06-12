import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evaluation_task/screens/cart_screen.dart';
import 'package:evaluation_task/components/reusable_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_data.dart';

class ProductScreen extends StatelessWidget {
  static String id = 'productScreen';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final CollectionReference _userRef =
  //     FirebaseFirestore.instance.collection('users');
  // User _user= FirebaseAuth.instance.currentUser;
  //
  // void addToCart() {
  //   return _userRef.doc(_user.uid).collection('cart').
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.view_headline_sharp),
          onPressed: () {},
        ),
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: Center(
              child: Text(
                '6',
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
      // drawer: Drawer(
      //   elevation: 10.0,
      //   child: ListView(
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.grey.shade500),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: <Widget>[
      //             CircleAvatar(
      //               backgroundImage: NetworkImage(
      //                   'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
      //               radius: 40.0,
      //             ),
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Text(
      //                   'Tom Cruise',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.white,
      //                       fontSize: 25.0),
      //                 ),
      //                 SizedBox(height: 10.0),
      //                 Text(
      //                   'tomcruise@gmail.com',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.white,
      //                       fontSize: 14.0),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                  );
                }

                final products = snapshot.data.docs;
                List<ReusableCards> productCards = [];

                for (var product in products) {
                  final image = product.get('image');
                  final name = product.get('name');
                  final price = product.get('price');

                  final cards = ReusableCards(
                    src: image,
                    name: name,
                    price: price,
                  );
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

// Column(
//   children: <Widget>[
//     Text('List of Products'),
//     ReusableCards(),
//     ReusableCards(),
//     ReusableCards(),
//   ],
// ),

// if (snapshot.connectionState == ConnectionState.done) {
//   return ListView(
//     children: snapshot.data.docs.map((document) {
//       return Container(
//         child: Image.network("${document.data()['image']}"),
//       );
//     }).toList(),
//   );
// }
