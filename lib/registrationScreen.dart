import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registrationScreen extends StatefulWidget{
  final VoidCallback showLoginScreen;
  const registrationScreen({
      Key? key,
      required this.showLoginScreen
  }) : super(key: key);

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override


  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }

  Future signUp() async {
    if (PasswordConfirmed()) {
      //Creates The User
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _userController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // adds user details to firestore

     addUserDetails(
       _firstNameController.text.trim(),
       _lastNameController.text.trim(),
     );
    }
  }

  Future addUserDetails(String firstName, String lastName) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'First Name': firstName,
        'Last Name': lastName,
      });
    } catch (e) {
      print('Error adding user details: $e');
    }
  }


  bool PasswordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPassword.text.trim()) {
      return true;
    }
    else {
      return false ;
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Register To Create An Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),

                //First Name

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
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '    First Name'
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
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '    Last Name'
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

                //Confirm   Password Input Box
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
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '   Confirm Password'
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //Sign up Button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
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

                SizedBox(height: 25),


                GestureDetector(
                  onTap: widget.showLoginScreen,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
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
