import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yummy_fly_v3/admin/admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2,
              ),
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    110.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Let\'s start with \n Admin!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Column(
                          children: [
                            SizedBox(height: 50.0),

                            Container(
                              padding: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                                left: 20.0,
                              ),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter username";
                                    }
                                    return null;
                                  },
                                  //for pass field
                                  obscuringCharacter: '*',
                                  obscureText: true,
                                  controller: userNameCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'username',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.person_outline),
                                    suffixIcon:
                                        userNameCtrl.text.isNotEmpty
                                            ? IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: () {
                                                userNameCtrl.clear();
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
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 16),
                                  textInputAction: TextInputAction.next,
                                  //use next to go next field
                                  keyboardType: TextInputType.text,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  cursorColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {}); // Update suffix icon
                                    // Add debounce logic if needed
                                  },
                                ),

                                /*
                                final TextEditingController searchController = TextEditingController();
                                final FocusNode searchFocusNode = FocusNode();

                                */
                              ),
                            ),

                            SizedBox(height: 40),

                            Container(
                              padding: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                                left: 20.0,
                              ),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     color: Color.fromARGB(255, 160, 160, 147),
                              //   ),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              child:
                              //
                              Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter username";
                                    }
                                    return null;
                                  },
                                  //for pass field
                                  obscuringCharacter: '*',
                                  obscureText: true,
                                  controller: userPassCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.password_outlined),
                                    suffixIcon:
                                        userPassCtrl.text.isNotEmpty
                                            ? IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: () {
                                                userPassCtrl.clear();
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
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 16),
                                  textInputAction: TextInputAction.search,
                                  //use next to go next field
                                  // use when you want to go next textfield
                                  //onEditingComplete: () => FocusScope.of(context).requestFocus(passFocusMode),
                                  keyboardType: TextInputType.text,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  cursorColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {}); // Update suffix icon
                                    // Add debounce logic if needed
                                  },
                                ),

                                /*
                                final TextEditingController searchController = TextEditingController();
                                final FocusNode searchFocusNode = FocusNode();

                                */
                              ),
                            ),

                            SizedBox(height: 40.0),

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  loginAdmin();
                                },
                                label: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  // Border
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  foregroundColor: Colors.black,
                                  shadowColor: Colors.black,
                                  elevation: 4,
                                  backgroundColor:
                                      Colors
                                          .transparent, // Optional (to stay outlined)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != userNameCtrl.text.trim()) {
          // Button click logic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is Wrong",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (result.data()['password'] != userPassCtrl.text.trim()) {
          // Button click logic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your Password is Wrong",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        }
      });
    });
  }
}
