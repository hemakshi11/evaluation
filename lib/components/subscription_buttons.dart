import 'package:evaluation_task/constants.dart';
import 'package:evaluation_task/user_product_details.dart';
import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';

class SubscriptionButtons extends StatelessWidget {
  final String text;
  var price;
  final Function onTap;
  SubscriptionButtons({this.text, this.price, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kContainerButtonColor,
          borderRadius: kContainerCircularBorders,
        ),
        height: 60,
        child: Text(
          '$text : $price/-',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
      onTap: onTap,
    );
  }
}
