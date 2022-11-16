import 'package:flutter/material.dart';
import 'package:nea/loginScreen.dart';
import 'package:nea/registrationScreen.dart';

class registration extends StatefulWidget{
  const registration ({Key? key}) : super(key: key);

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {

  //Showing the Login Page at the Start
  bool showLoginScreen = true;

  void toggleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(showRegistrationScreen: toggleScreens);
    } else {
      return registrationScreen(showLoginScreen: toggleScreens);
    }
  }
}