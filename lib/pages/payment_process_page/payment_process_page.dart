import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:izzi_ride_2/UI/payment_card_widget/payment_card_widget.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/payment_card_model.dart';

class PaymentProcessPage extends StatefulWidget {
  const PaymentProcessPage({super.key});

  @override
  State<PaymentProcessPage> createState() => _PaymentProcessPageState();
}

class _PaymentProcessPageState extends State<PaymentProcessPage> {


  String variableCardId = "1";

  void variableCard(String id){
    setState(() {
      variableCardId=id;
    });
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                PaymentCardWidget(
                  card: PaymentCardModel(
                    cardId: "1",
                    cardNumber: "123124134324234",
                    isSaved: true,
                  ),
                  isVariable: variableCardId=="1",
                  variableCard: variableCard,
                ),
                SizedBox(height: 20,),
                PaymentCardWidget(
                  card: PaymentCardModel(
                    cardId: "2",
                    cardNumber: "313131313",
                    isSaved: true,
                  ),
                  isVariable: variableCardId=="2",
                  variableCard: variableCard,
                ),
                SizedBox(height: 20,),
                PaymentCardWidget(
                  card: PaymentCardModel(
                    cardId: "0",
                    cardNumber: "New card",
                    isSaved: false
                  ),
                  isVariable: variableCardId=="0",
                  variableCard: variableCard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}