import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String id = 'cartScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.view_headline_sharp),
          onPressed: () {},
        ),
        title: Text(
          'Cart',
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
      body: ListView(
        children: [
          Container(
            child: Center(
              child: Text('hello'),
            ),
          ),
        ],
      ),
    );
  }
}
