import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:yummy_fly_v3/admin/admin_home.dart';
import 'package:yummy_fly_v3/widget/widget_supports.dart';

class AddFoodItems extends StatefulWidget {
  const AddFoodItems({super.key});

  @override
  State<AddFoodItems> createState() => _AddFoodItemsState();
}

class _AddFoodItemsState extends State<AddFoodItems> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController DetailCtrl = TextEditingController();
  String? value;
  final List<String> items = ['Ice-Cream', 'Pizza', 'Salad', 'Burger'];

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() {
    if (selectedImage != null &&
        nameCtrl.text != "" &&
        priceCtrl != "" &&
        DetailCtrl != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('blogImages')
          .child(addId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text('Add Item', style: Appwidget.HeadlineTextFeildStyle()),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 50.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Food Picture",
                style: Appwidget.semiBoldTextFeildStyle(),
              ),
              SizedBox(height: 20.0),
              selectedImage == null
                  ? Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  : Center(
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),

              SizedBox(height: 30.0),
              Text('Food Name', style: Appwidget.semiBoldTextFeildStyle()),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Food Name",
                    hintStyle: Appwidget.LightTextFeildStyle(),
                  ),
                ),
              ),

              SizedBox(height: 30.0),
              Text('Food Price', style: Appwidget.semiBoldTextFeildStyle()),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  controller: priceCtrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Food Price",
                    hintStyle: Appwidget.LightTextFeildStyle(),
                  ),
                ),
              ),

              SizedBox(height: 30.0),
              Text('Food Detail', style: Appwidget.semiBoldTextFeildStyle()),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  maxLines: 4,
                  controller: DetailCtrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Food Detail",
                    hintStyle: Appwidget.LightTextFeildStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Select Category',
                style: Appwidget.semiBoldTextFeildStyle(),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items:
                        items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged:
                        ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text('Select Category'),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),

              SizedBox(height: 30.0),

              Center(
                child: SizedBox(
                  width: 200, // You can adjust this width
                  child: ElevatedButton(
                    onPressed: () {
                      // Button logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
