import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nea/loginScreen.dart';
import 'dashboardScreen.dart';

class dashboard extends StatelessWidget{
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot) {
            if (snapshot.hasData){
              return dashboardScreen();
            } else{
              return LoginScreen();
            }
        }
      ),
    );
  }
}