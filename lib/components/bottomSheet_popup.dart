import 'package:evaluation_task/constants.dart';
import 'package:evaluation_task/user_product_details.dart';
import 'package:evaluation_task/user_products.dart';
import 'package:flutter/material.dart';
import 'subscription_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BottomSheetPage extends StatefulWidget {
  final product;
  BottomSheetPage({this.product});

  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff161616),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          color: kContainerButtonColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Subcription Prices',
              textAlign: TextAlign.center,
              style: TextStyle(
                //color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SubscriptionButtons(
                text: '12 months',
                price: widget.product['price']['12months'],
                onTap: () {
                  // Scaffold.of(context).showSnackBar(
                  //     SnackBar(content: Text('Product added to the Cart')));
                  Provider.of<Users>(context, listen: false).addProduct(
                      name: widget.product['name'],
                      image: widget.product['image'],
                      price: widget.product['price']['12months'],
                      type: '12months');
                  Navigator.pop(context);
                }),
            SizedBox(height: 10),
            SubscriptionButtons(
                text: '6 months',
                price: widget.product['price']['6months'],
                onTap: () {
                  Provider.of<Users>(context, listen: false).addProduct(
                      name: widget.product['name'],
                      image: widget.product['image'],
                      price: widget.product['price']['6months'],
                      type: '6months');
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
