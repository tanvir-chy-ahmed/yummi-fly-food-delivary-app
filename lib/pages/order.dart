import 'package:flutter/material.dart';

import '../widget/widget_supports.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is Order", style: Appwidget.HeadlineTextFeildStyle()),
    );
  }
}
