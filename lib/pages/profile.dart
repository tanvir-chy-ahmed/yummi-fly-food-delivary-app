import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yummy_fly_v3/service/shared_pref.dart';
import '../AccountAuthCreation/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isLoading = false;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      await SharedPreferencesHelp().saveProfileImage(image.path);
      setState(() {});
    }
  }

  getthesharedpref() async {
    profile = await SharedPreferencesHelp().getProfileImage();
    name = await SharedPreferencesHelp().getUserName();
    email = await SharedPreferencesHelp().getUserEmail();
    
    if (profile != null && await File(profile!).exists()) {
      selectedImage = File(profile!);
    }
    setState(() {});
  }

  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      await SharedPreferencesHelp().clearUserData();
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteAccount() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      // Here you would typically make an API call to delete the user's account
      await SharedPreferencesHelp().clearUserData();
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : name == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black87, Colors.black],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => getImage(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.grey[200],
                                          backgroundImage: selectedImage != null
                                              ? FileImage(selectedImage!)
                                              : AssetImage("assets/boy.jpg") as ImageProvider,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Text(
                                    name ?? 'Your Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    email ?? 'your.email@example.com',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildProfileItem(Icons.person, "Name", name ?? 'Not set'),
                      _buildProfileItem(Icons.email, "Email", email ?? 'Not set'),
                      _buildProfileItem(Icons.notifications_outlined, "Notifications", "Manage"),
                      _buildProfileItem(Icons.language, "Language", "English"),
                      _buildProfileItem(Icons.description, "Terms and Conditions", ""),
                      _buildProfileItem(Icons.privacy_tip_outlined, "Privacy Policy", ""),
                      _buildActionItem(
                        Icons.delete_outline,
                        "Delete Account",
                        Colors.red,
                        onTap: showDeleteConfirmation,
                      ),
                      _buildActionItem(
                        Icons.logout,
                        "Logout",
                        Colors.black,
                        onTap: logout,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: value.isNotEmpty
            ? Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              )
            : null,
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle navigation or action for each item
        },
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, Color color, {VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
