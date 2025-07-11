import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yummy_fly_v3/AccountAuthCreation/onboard.dart';
import 'package:yummy_fly_v3/widget/AppConstant.dart';

void main() async {
  Stripe.publishableKey = publishableKey;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Onboard());
  }
}

// Onboard()
