import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yummy_fly_v3/AccountAuthCreation/signup.dart';

import '../pages/bottomnav.dart';
import '../widget/widget_supports.dart';
import 'forgetpass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final FocusNode loginFocusMode = FocusNode();
  final FocusNode passFocusMode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Future<void> userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ Navigate to BottomNav on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      } else {
        message = 'Error: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
              ),
            ),
          ),

          // White Bottom Sheet
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),

          // Foreground Login Form
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/yummi.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 50.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text('Login', style: Appwidget.HeadlineTextFeildStyle()),
                          SizedBox(height: 30),

                          // Email
                          TextFormField(
                            controller: emailCtrl,
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Please enter email' : null,
                            focusNode: loginFocusMode,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: Appwidget.semiBoldTextFeildStyle(),
                              prefixIcon: Icon(Icons.email_outlined),
                              suffixIcon: emailCtrl.text.isNotEmpty
                                  ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  emailCtrl.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(fontSize: 16),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(passFocusMode),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => setState(() {}),
                          ),

                          SizedBox(height: 20),

                          // Password
                          TextFormField(
                            controller: passwordCtrl,
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Please enter password' : null,
                            obscureText: true,
                            obscuringCharacter: '*',
                            focusNode: passFocusMode,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: Appwidget.semiBoldTextFeildStyle(),
                              prefixIcon: Icon(Icons.password_outlined),
                              suffixIcon: passwordCtrl.text.isNotEmpty
                                  ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  passwordCtrl.clear();
                                  setState(() {});
                                },
                              )
                                  : null,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            style: TextStyle(fontSize: 16),
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () => FocusScope.of(context).unfocus(),
                            onChanged: (value) => setState(() {}),
                          ),

                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> ForgetPass()));
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot Password',
                                style: Appwidget.semiBoldTextFeildStyle(),
                              ),
                            ),
                          ),

                          SizedBox(height: 60),

                          // Login Button
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailCtrl.text.trim();
                                  password = passwordCtrl.text;
                                });
                                await userLogin();
                              }
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xffff5722),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 70),

                // Sign Up Redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Appwidget.semiBoldTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        ' Sign Up',
                        style: Appwidget.loginBoldTextFeildStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
