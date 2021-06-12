import 'package:evaluation_task/screens/cart_screen.dart';
import 'package:evaluation_task/screens/login_screen.dart';
import 'package:evaluation_task/screens/product_screen.dart';
import 'package:evaluation_task/screens/register_screen.dart';
import 'package:evaluation_task/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'product_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (content) => ProductData(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: WelcomeScreen.id,
        routes: {
          ProductScreen.id: (context) => ProductScreen(),
          CartScreen.id: (context) => CartScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen()
        },
      ),
    );
  }
}
