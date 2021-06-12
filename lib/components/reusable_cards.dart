import 'package:evaluation_task/user_products.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'bottomSheet_popup.dart';

class ReusableCards extends StatelessWidget {
  final String src;
  final String name;
  final price;
  var productData;
  ReusableCards({this.src, this.name, this.price, this.productData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: kContainerButtonColor,
          borderRadius: kContainerCircularBorders,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: 350,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: kContainerCircularBorders,
                ),
                child: ClipRRect(
                  borderRadius: kContainerCircularBorders,
                  child: Image.network(
                    '$src',
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              '${name.toUpperCase()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      BottomSheetPage(price: price, src: src, name: name),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add to the cart',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
