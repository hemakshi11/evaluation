import 'package:evaluation_task/screens/cart_screen.dart';
import 'package:evaluation_task/screens/product_screen.dart';
import 'package:evaluation_task/screens/welcome_screen.dart';
import 'package:evaluation_task/user_product_details.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DrawerForApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  // padding: EdgeInsets.only(
                  //   top: 90,
                  // ),
                  decoration: BoxDecoration(color: Colors.black45),
                  accountName: Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Text(
                      'Hello',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  accountEmail: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text(auth.currentUser.email),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductScreen.id);
                  },
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      child: Text(
                        "Go to Product's page",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Divider(
                    color: Colors.white30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      child: Text(
                        'Go to Cart',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Divider(
                    color: Colors.white30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    auth.signOut();
                    Provider.of<Users>(context, listen: false).products.clear();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Divider(
                    color: Colors.white30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
