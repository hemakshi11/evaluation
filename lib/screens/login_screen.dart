import 'package:evaluation_task/screens/product_screen.dart';
import 'package:evaluation_task/user_product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../user_products.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("completed");
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Consumer<Users>(
            builder: (context, productDetails, child) => RoundedButtons(
              onpressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.user.uid)
                        .collection('cart')
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        print(element.data());
                        productDetails.products.add(new UserProducts(
                            name: element['name'],
                            price: element['price'],
                            type: element['type'],
                            image: element['image']));
                      });
                    });
                    Navigator.pushNamed(context, ProductScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
              },
              title: 'Log In',
              colour: kTeal,
            ),
          ),
        ],
      ),
    );
  }
}
