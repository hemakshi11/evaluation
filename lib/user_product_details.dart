import 'package:evaluation_task/user_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/product_screen.dart';
import 'package:flutter/material.dart';

bool changeColor = false;

// UserProducts userProducts = UserProducts();

class Users extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static List firestoreCart = [];

  List products = [];
  // firestoreCart.map((e) {
  //         new UserProducts(
  //             name: e['name'],
  //             price: e['price'],
  //             type: e['type'],
  //             image: e['image']);
  //       }).toList()
  //    ;

  void addProduct(
      {String name,
      String image,
      var price,
      String type,
      BuildContext context}) {
    print(products);
    final product =
        UserProducts(name: name, image: image, price: price, type: type);

    Iterable isThere = products.where((i) => i.name.contains(name));

    if (isThere.isNotEmpty) {
      print('Product already in cart');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Product already in the Cart',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )));

      notifyListeners();
    } else {
      products.add(product);
      notifyListeners();
      // print(products);
      // print(product.name);

      _firestore.collection('users').doc(user.uid).collection('cart').add({
        'name': name,
        'type': type,
        'image': image,
        'price': price,
        'timeStamp': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Product added to the Cart',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )));
      changeColor = true;
      notifyListeners();
    }
  }

  int get productCount {
    return products.length;
  }
  // bool showSnackBar(){
  //   if ()
  // }

  void deleteProduct(name) {
    var item;

    products.where((element) => element.name == name).forEach((elem) {
      item = elem;
    });
    products.remove(item);

    notifyListeners();
  }

  void logOff() {
    products.clear();
    notifyListeners();
  }
}
