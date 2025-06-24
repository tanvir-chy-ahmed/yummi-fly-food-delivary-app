import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:yummy_fly_v3/AccountAuthCreation/signup.dart';

import '../widget/widget_supports.dart';
class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController emailCtrl = TextEditingController();
  final FocusNode emailFocusMode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> resetPassword() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailCtrl.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Reset email has been sent!", style: TextStyle(fontSize: 18.0)),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("No user found with that email", style: TextStyle(fontSize: 18.0)),
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            const Text(
              'Password Recovery',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Enter your mail',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: emailCtrl,
                        focusNode: emailFocusMode,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter email' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: Appwidget.semiBoldTextFeildStyle().copyWith(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
                          suffixIcon: emailCtrl.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              emailCtrl.clear();
                              setState(() {});
                            },
                          )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.blueAccent),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                        ),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          resetPassword();
                        }
                      },
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : const Text(
                            'Send Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const Signup()));
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(
                              color: Color.fromARGB(225, 184, 166, 6),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
