import 'package:evaluation_task/user_products.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'bottomSheet_popup.dart';

class ReusableCards extends StatelessWidget {
  final product;
  ReusableCards({this.product});

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
                    '${product['image']}',
                    fit: BoxFit.cover,
                  ),
                )),
            Text(
              '${product['name'].toUpperCase()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetPage(product: product),
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
