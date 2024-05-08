import 'package:flutter/material.dart';
import 'package:wellness_ui/NewProfile.dart';
import 'package:wellness_ui/doctor_consultation.dart';
import 'package:wellness_ui/login_otp.dart';
import 'package:wellness_ui/login_screen.dart';
import 'package:wellness_ui/navbar.dart';
import 'package:wellness_ui/order_summary.dart';
import 'package:wellness_ui/paymentSummary.dart';
import 'package:wellness_ui/services_accordian.dart';
import 'package:wellness_ui/signup.dart';
// import 'package:wellness_ui/login_screen.dart';
import 'package:wellness_ui/subscription_plan.dart';
import 'package:wellness_ui/subscription_pricing.dart';
import 'package:wellness_ui/test.dart';
import 'package:wellness_ui/viewSubscription.dart';

import 'AppandSidebar.dart';
import 'CommonAppBar.dart';
import 'LandingPage.dart';
import 'PaymentSuccessful.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wellness',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LandingPage()
      // home: const SignUp()
      // home: OTPScreen()
      // home: const SubscriptionPlan()
      // home: const SubscriptionPricing()
      // home:Navbar()
      home: LandingPage(),

      initialRoute: '/',
      routes: {
        '/landing_Page': (context) => const LandingPage(),
        '/login_otp': (context) => OTPScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUp(),
        '/payment_success': (context) => const PaymentSuccessful(),
        '/subscription_plan': (context) => const SubscriptionPlan(),
        '/subscription_pricing': (context) => const SubscriptionPricing(),
      },
    );
  }
}
