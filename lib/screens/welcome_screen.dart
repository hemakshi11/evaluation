import 'package:evaluation_task/constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_buttons.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Center(
            child: TypewriterAnimatedTextKit(
              text: ['WELCOME'],
              textStyle: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90.0),
            child: SizedBox(
              height: 50.0,
              //width: 250.0,
              child: Divider(
                color: Color(0xffBDBDBD),
              ),
            ),
          ),
          RoundedButtons(
            onpressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            title: 'Log In',
            colour: kTeal,
          ),
          RoundedButtons(
            onpressed: () {
              Navigator.pushNamed(context, RegisterScreen.id);
            },
            title: 'Register',
            colour: Colors.teal[800],
          ),
        ],
      ),
    );
  }
}
