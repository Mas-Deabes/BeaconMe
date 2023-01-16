import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _userController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _userController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Reset Link Successfully Sent, Check Your Mailbox!'),
        );
      });
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter Your Email To Reset Your Password',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color:  Colors.white70,
                border: Border.all(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '    Email - Username'
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          MaterialButton(
              onPressed: passwordReset,
              child:  Text('Reset Password'),
            color: Colors.tealAccent,
          ),
        ],
      )
    );
  }
}
