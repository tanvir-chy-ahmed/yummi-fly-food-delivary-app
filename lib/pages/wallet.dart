import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:yummy_fly_v3/service/shared_pref.dart';
import '../widget/AppConstant.dart';

class Wallet extends StatefulWidget {
  final double? amount;
  final bool isFromCart;

  const Wallet({super.key, this.amount, this.isFromCart = false});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet;
  int selectedAmount = 0;
  Map<String, dynamic>? paymentIntent;
  String selectedPaymentMethod = 'card';
  bool isLoading = false;

  final TextEditingController customAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.amount != null) {
      selectedAmount = widget.amount!.toInt();
      customAmountController.text = widget.amount!.toString();
    }
    getSharedPref();
  }

  Future<void> getSharedPref() async {
    wallet = await SharedPreferencesHelp().getUserWallet();
    setState(() {});
  }

  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }

  Future<void> makePayment(String amount) async {
    setState(() {
      isLoading = true;
    });

    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      if (paymentIntent == null) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error creating payment. Please try again.'),
          ),
        );
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: me,
        ),
      );
      await displayPaymentSheet(amount);
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      final newAmount = int.parse(wallet ?? '0') + int.parse(amount);
      await SharedPreferencesHelp().saveUserWallet(newAmount.toString());

      if (mounted) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                    SizedBox(height: 16),
                    Text(
                      'Payment Successful',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Amount: \$${amount}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
        );
      }

      await getSharedPref();
      paymentIntent = null;

      if (widget.isFromCart) {
        // Handle cart payment success
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } on StripeException catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    SizedBox(height: 16),
                    Text(
                      'Payment Cancelled',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Stripe API Error: ${response.body}');
        return null;
      }
    } catch (err) {
      print('Error creating payment intent: ${err.toString()}');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.isFromCart ? 'Checkout' : 'My Wallet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
              : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wallet Card
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF000000), Color(0xFF1a1a1a)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Card Design Elements
                          Positioned(
                            right: -50,
                            top: -50,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -30,
                            bottom: -30,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                          // Card Content
                          Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Available Balance',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/wallet.png',
                                      height: 30,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  '₹${wallet ?? "0"}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Updated just now',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick Add Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Add',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              padding: EdgeInsets.all(15),
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1.5,
                              children: [
                                for (int amount in [
                                  100,
                                  500,
                                  1000,
                                  2000,
                                  5000,
                                  10000,
                                ])
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAmount = amount;
                                        customAmountController.text =
                                            amount.toString();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            selectedAmount == amount
                                                ? Colors.black
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '₹$amount',
                                          style: TextStyle(
                                            color:
                                                selectedAmount == amount
                                                    ? Colors.white
                                                    : Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Custom Amount Section
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Custom Amount',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: customAmountController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedAmount = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter amount',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    '₹',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Add Money Button
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: ElevatedButton(
                        onPressed:
                            selectedAmount > 0
                                ? () => makePayment(selectedAmount.toString())
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(double.infinity, 60),
                        ),
                        child: Text(
                          widget.isFromCart ? 'Pay Now' : 'Add Money',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
