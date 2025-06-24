import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:yummy_fly_v3/service/database.dart';
import 'package:yummy_fly_v3/service/shared_pref.dart';

import '../pages/bottomnav.dart';
import '../widget/widget_supports.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String name = '',email = '',password='';

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final FocusNode nameFocusMode = FocusNode();
  final FocusNode emailFocusMode = FocusNode();
  final FocusNode passFocusMode = FocusNode();

  final _fromKey = GlobalKey<FormState>();


  registration()async{
    if(password!= null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("Registration Successfully",style: TextStyle(fontSize: 20.0),
              )),);
        String Id = randomAlphaNumeric(10);
        Map<String,dynamic> addUserInfo={
          "Name" : nameCtrl.text,
          "Email" : emailCtrl.text,
          "Wallet" : "0",
          "Id" : Id
        };

        await DatabaseMethod().addUserDetail(addUserInfo, Id);
        await SharedPreferencesHelp().saveUserName(nameCtrl.text);
        await SharedPreferencesHelp().saveUserEmail(emailCtrl.text);
        await SharedPreferencesHelp().saveUserWallet('0');
        await SharedPreferencesHelp().saveUserId(Id);

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> BottomNav()));
      }on FirebaseException catch(e){
        if(e.code == 'weak-password'){
          // Button click logic
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Provided Password is too weak",style: TextStyle(fontSize: 18.0))),
          );
        }else if(e.code == 'email-already-in-use'){
          // Button click logic
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Account Already Exists",style: TextStyle(fontSize: 18.0),)),
          );
        }
      }
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
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
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Text(''),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
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
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.8,
                      //here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: _fromKey,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'SignUp',
                              style: Appwidget.HeadlineTextFeildStyle(),
                            ),
                            SizedBox(height: 30),
                        
                            TextFormField(
                              controller: nameCtrl,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter Name';
                                }
                                return null;
                              },

                              focusNode: nameFocusMode,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: Appwidget.semiBoldTextFeildStyle(),
                                prefixIcon: Icon(Icons.person_outline),
                                suffixIcon:
                                    nameCtrl.text.isNotEmpty
                                        ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            nameCtrl.clear();
                                            setState(
                                              () {},
                                            ); // Optional: update UI
                                          },
                                        )
                                        : null,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.next,
                              onEditingComplete:
                                  () => FocusScope.of(
                                    context,
                                  ).requestFocus(emailFocusMode),
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              enableSuggestions: true,
                              cursorColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {}); // Update suffix icon
                                // Add debounce logic if needed
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter e-mail';
                                }
                                return null;
                              },

                              controller: emailCtrl,
                              focusNode: emailFocusMode,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: Appwidget.semiBoldTextFeildStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                                suffixIcon:
                                    emailCtrl.text.isNotEmpty
                                        ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            emailCtrl.clear();
                                            setState(
                                              () {},
                                            ); // Optional: update UI
                                          },
                                        )
                                        : null,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.next,
                              onEditingComplete:
                                  () => FocusScope.of(
                                    context,
                                  ).requestFocus(passFocusMode),
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              enableSuggestions: true,
                              cursorColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {}); // Update suffix icon
                                // Add debounce logic if needed
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please Enter Password';
                                }
                                return null;
                              },

                              obscuringCharacter: '*',
                              obscureText: true,
                              controller: passwordCtrl,
                              focusNode: passFocusMode,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: Appwidget.semiBoldTextFeildStyle(),
                                prefixIcon: Icon(Icons.password_outlined),
                                suffixIcon:
                                    passwordCtrl.text.isNotEmpty
                                        ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            passwordCtrl.clear();
                                            setState(
                                              () {},
                                            ); // Optional: update UI
                                          },
                                        )
                                        : null,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              enableSuggestions: true,
                              cursorColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {}); // Update suffix icon
                                // Add debounce logic if needed
                              },
                            ),
                        
                            SizedBox(height: 60),
                            GestureDetector(
                              onTap: ()async{
                                if(_fromKey.currentState!.validate()){
                                  setState(() {
                                    email = emailCtrl.text;
                                    password = passwordCtrl.text;
                                    name = nameCtrl.text;
                                  });
                                }
                                registration();

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
                                      'SIGN UP',
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Appwidget.semiBoldTextFeildStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'Login',
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
      ),
    );
  }
}
