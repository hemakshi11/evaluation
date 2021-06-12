import 'package:evaluation_task/user_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
User user = _auth.currentUser;

class Users extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserProducts> products = [];

  void addProduct(String name, String src, var price) {
    final product = UserProducts(name: name, src: src, price: price);
    products.add(product);
    notifyListeners();
    print(products);
    _firestore.collection('users').doc(user.uid).collection('cart').add({
      'name': name,
      'src': src,
      'price': price,
      'timeStamp': DateTime.now(),
    });
  }

  int get productCount {
    return products.length;
  }
}
