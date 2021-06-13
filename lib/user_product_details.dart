import 'package:evaluation_task/user_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/product_screen.dart';

final auth = FirebaseAuth.instance;
User user = auth.currentUser;

class Users extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserProducts> products = [];

  void addProduct({String name, String image, var price, String type}) {
    final product =
        UserProducts(name: name, image: image, price: price, type: type);

    // if (false) {
    //   print('Product already in cart');
    // } else {
    products.add(product);
    notifyListeners();
    print(products);
    print(product.name);
    _firestore.collection('users').doc(user.uid).collection('cart').add({
      'name': name,
      'type': type,
      'image': image,
      'price': price,
      'timeStamp': DateTime.now(),
    });
    //}
  }

  int get productCount {
    return products.length;
  }

  void deleteProduct(product) {
    products.remove(product);
    notifyListeners();
  }

  // bool checkInCart() {
  //   isThere = !isThere;
  //   notifyListeners();
  // }
}
