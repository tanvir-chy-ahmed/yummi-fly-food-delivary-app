import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yummy_fly_v3/pages/cart.dart';
import 'package:yummy_fly_v3/pages/profile.dart';
import 'package:yummy_fly_v3/pages/wallet.dart';

import 'home.dart';
import 'order.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Cart cart;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    homepage = Home();
    cart = Cart();
    profile = Profile();
    order = Order();
    wallet = Wallet();
    pages = [homepage, cart, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
