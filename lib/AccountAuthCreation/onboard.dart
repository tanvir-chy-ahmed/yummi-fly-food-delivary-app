import 'package:flutter/material.dart';
import 'package:yummy_fly_v3/AccountAuthCreation/signup.dart';

import '../widget/content_model.dart';
import '../widget/widget_supports.dart';


class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              controller: _controller,
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.only(top: 40,left: 20.0,right: 20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 450,
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        contents[i].title,
                        style: Appwidget.semiBoldTextFeildStyle(),
                      ),
                      SizedBox(height: 5),
                      Text(
                        contents[i].description,
                        style: Appwidget.LightTextFeildStyle(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              } else {
                _controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },

            child: Container(
              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),
              height: 60.0,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: Center(child: Text(
                  currentIndex == contents.length - 1?
                  'Start' : "Next",

                  style: TextStyle(color: Colors.white,fontSize:20.0,fontWeight: FontWeight.bold ))),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.black38,
      ),
    );
  }
}
