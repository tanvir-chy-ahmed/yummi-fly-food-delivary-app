import 'package:flutter/material.dart';
import '../widget/widget_supports.dart';
import 'wallet.dart';

class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // This would typically come from a state management solution
  List<CartItem> cartItems = [
    CartItem(
      name: 'Mediterranean Chickpea Salad',
      image: 'assets/salad2.png',
      price: 28.0,
      quantity: 1,
    ),
    CartItem(
      name: 'Mix Veg Salad',
      image: 'assets/salad2.png',
      price: 28.0,
      quantity: 1,
    ),
  ];

  double get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        cartItems[index].quantity++;
      } else if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Cart',
                    style: Appwidget.HeadlineTextFeildStyle(),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${cartItems.length} items',
                    style: Appwidget.LightTextFeildStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 100,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add items to start a cart',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Dismissible(
                          key: Key(item.name),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          onDismissed: (direction) => removeItem(index),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
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
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    item.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => updateQuantity(index, true),
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => updateQuantity(index, false),
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (cartItems.isNotEmpty)
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '\$${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Wallet(
                                amount: totalAmount,
                                isFromCart: true,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
} 