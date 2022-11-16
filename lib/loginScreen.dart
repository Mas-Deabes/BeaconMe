import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  Future SignIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userController.text.trim(),
        password: _passwordController.text.trim(),
    );
  }

  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                    'assets/images/Logo.png',
                  height: 250,
                  width: 250,
                ),
                //Greet Message to User
                SizedBox(height: 10),

                Text(
                  'Log In To Access the Dashboard',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),

                //Username or Email Input Box

                SizedBox(height: 50),

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

                //Password Input Box
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '    Password'
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //Sign in Button
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: SignIn,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Don't Have an Account?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Register Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}