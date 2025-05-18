import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class PaymentCardPage extends StatefulWidget {
  const PaymentCardPage({super.key});

  @override
  State<PaymentCardPage> createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}