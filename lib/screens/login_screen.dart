import 'package:evaluation_task/screens/product_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          RoundedButtons(
            onpressed: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (user != null) {
                  Navigator.pushNamed(context, ProductScreen.id);
                }
              } catch (e) {
                print(e);
              }
            },
            title: 'Log In',
            colour: kTeal,
          ),
        ],
      ),
    );
  }
}
