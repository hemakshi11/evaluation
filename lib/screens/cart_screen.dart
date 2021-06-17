import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evaluation_task/components/drawerForApp.dart';
import 'package:evaluation_task/screens/final_order.dart';
import 'package:evaluation_task/user_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../user_product_details.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
List cartList = [];

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class CartScreen extends StatefulWidget {
  static String id = 'cartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Alert(
      //       context: context,
      //       type: AlertType.none,
      //       title: "Check-Out",
      //       desc: "Proceed with the current items in your cart?",
      //       style: AlertStyle(backgroundColor: Colors.white54),
      //       buttons: [
      //         DialogButton(
      //           child: Text(
      //             "No",
      //             style: TextStyle(color: Colors.black54, fontSize: 20),
      //           ),
      //           onPressed: () => Navigator.pop(context),
      //           color: kContainerColor,
      //         ),
      //         DialogButton(
      //           child: Text(
      //             "Yes",
      //             style: TextStyle(color: Colors.black54, fontSize: 20),
      //           ),
      //           onPressed: () => Navigator.pushNamed(context, FinalOrder.id),
      //           color: kContainerColor,
      //         )
      //       ],
      //     ).show();
      //   },
      //   child: Icon(Icons.check),
      // ),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: Center(
              child: Text(
                Provider.of<Users>(context).products.length.toString(),
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
      drawer: DrawerForApp(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: ConsumerForCart()),
          Container(
            //margin: EdgeInsets.only(top: 10),
            height: 58,
            decoration: BoxDecoration(
              color: Colors.tealAccent.shade700,

              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: FlatButton(
              onPressed: () {
                // Alert(
                //         context: context,
                //         title: "RFLUTTER",
                //         desc: "Flutter is awesome.")
                //     .show();
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Your order is successful",
                  content: SizedBox(
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                        itemCount: cartList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          'Name: ${cartList[index].get('name').toUpperCase()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'Subscription: ${cartList[index].get('type')}',
                                            style: TextStyle(fontSize: 16.5)),
                                        Text(
                                            'Price: ${cartList[index].get('price')}/-',
                                            style: TextStyle(fontSize: 16.5)),
                                      ]),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  // builder; cartlist[index].get('')

                  style: AlertStyle(backgroundColor: Colors.white54),
                  buttons: [
                    // DialogButton(
                    //   child: Text(
                    //     "No",
                    //     style: TextStyle(color: Colors.black54, fontSize: 20),
                    //   ),
                    //   onPressed: () => Navigator.pop(context),
                    //   color: kContainerColor,
                    // ),
                    DialogButton(
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: kContainerColor,
                    )
                  ],
                ).show();
              },
              child: Text('CHECK-OUT', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

class ConsumerForCart extends StatefulWidget {
  @override
  _ConsumerForCartState createState() => _ConsumerForCartState();
}

class _ConsumerForCartState extends State<ConsumerForCart> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    // print(user.uid);

    return Consumer<Users>(builder: (context, productDetails, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('users')
              .doc(user.uid)
              .collection('cart')
              .orderBy('timeStamp')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('ERROR: ${snapshot.error}'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.teal,
                ),
              );
            }
            // cartList.clear();
            print(snapshot.data.docs.first.data());
            cartList = snapshot.data.docs;
            // setState(() {});
            // productDetails.products = cartList.map((e) {
            //   new UserProducts(
            //       name: e.get('name'),
            //       price: e.get('price'),
            //       image: e.get('image'),
            //       type: e.get('type'));
            // }).toList();
            // print(snapshot.data.docs.first.data());
            print(productDetails.products);
            // for (var i in cartList) {
            //   Provider.of<Users>(context).addProduct(
            //       name: i.get('name'),
            //       image: i.get('image'),
            //       price: i.get('price'),
            //       type: i.get('type'));
            // }
            // cartList.clear();
            return cartList.isEmpty
                ? Center(child: Text('No products'))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final product = productDetails.products[index];
                      // print(product.name);
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: kContainerCircularBorders,
                            color: kContainerButtonColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 150,
                                width: 150,
                                padding: EdgeInsets.all(10),
                                // decoration: BoxDecoration(
                                //   borderRadius: kContainerCircularBorders,
                                //   color: kContainerButtonColor,
                                // ),
                                child: ClipRRect(
                                  borderRadius: kContainerCircularBorders,
                                  child: Image.network(
                                    cartList[index].get('image'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        'Name: ${cartList[index].get('name').toUpperCase()}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'Subscription: ${cartList[index].get('type')}',
                                          style: TextStyle(fontSize: 16.5)),
                                      Text(
                                          'Price: ${cartList[index].get('price')}/-',
                                          style: TextStyle(fontSize: 16.5)),
                                    ],
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (ctx) => IconButton(
                                    icon: Icon(Icons.clear_rounded),
                                    onPressed: () async {
                                      var name = cartList[index].get('name');
                                      print(cartList[index].id);
                                      await _firestore
                                          .collection('users')
                                          .doc(user.uid)
                                          .collection('cart')
                                          .doc(cartList[index].id)
                                          .delete();
                                      // .orderBy('timeStamp')
                                      //   .where("name",
                                      //       isEqualTo:
                                      //           cartList[index].id .get('name'))
                                      //   .get()
                                      //   .then((value) {
                                      // value.docs.forEach((element) {
                                      //   FirebaseFirestore.instance
                                      //       .collection("users")
                                      //       .doc(user.uid)
                                      //       .collection('cart')
                                      //       .doc(element.id)
                                      //       .delete()
                                      //       .then((value) {
                                      //     print("Success!");
                                      //   });
                                      //   });
                                      // });
                                      productDetails.deleteProduct(name);
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Product deleted from the cart',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.black,
                                      ));
                                    }),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    //shrinkWrap: true,
                    itemCount: cartList.length,
                  );
          });
    });
  }
}
