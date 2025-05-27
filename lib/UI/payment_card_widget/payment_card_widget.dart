import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/http/payment_http.dart';
import 'package:izzi_ride_2/core/models/payment_card_model.dart';
import 'package:izzi_ride_2/core/models/payment_intent_model.dart';
import 'package:izzi_ride_2/core/models/response.dart';

class PaymentCardWidget extends StatefulWidget {
  final PaymentCardModel card;
  final bool isVariable;
  final Function(String id) variableCard;
  const PaymentCardWidget({super.key,required this.card,required this.isVariable,required this.variableCard});

  @override
  State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {


  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final CardEditController _cardEditController = CardEditController();
  final CardFormEditController _cardFormEditController = CardFormEditController();
  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PaymentCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVariable != oldWidget.isVariable && widget.isVariable==false) {
      clearCard();
    }
    if (widget.isVariable != oldWidget.isVariable && widget.isVariable==true) {
      focuseCard();
    }
  }

  clearCard(){
    _textEditingController.text="";
  }
  focuseCard(){
    _focusNode.requestFocus();
  }

  pay()async{
    final result = await PaymentHttp.I.init();
    if(result is CustomResponse<PaymentIntentModel>){
      final data = result.data;
      final billingInfo = SetupPaymentSheetParameters(
        merchantDisplayName: 'EasyRide',
        customerId: data.customerId,
        paymentIntentClientSecret: data.clientSecret,
        customerEphemeralKeySecret: data.ephermKey,
        allowsDelayedPaymentMethods: false,
        style: ThemeMode.light,
      );
      final res = await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: billingInfo,
      );
      await Stripe.instance.presentPaymentSheet();
    }
  //   billingInfo  = await Stripe.instance.initPaymentSheet(
  //   paymentSheetParameters: SetupPaymentSheetParameters(
  //     merchantDisplayName: 'My App Name', // 👈 обязателен
  //     customerId: 'cus_123',              // от сервера
  //     paymentIntentClientSecret: 'seti_1RK12i06u8jzHB84yMu3E022_secret_SEU0U32O70wNOD5szrouuYkRu1d1wfC', // от сервера
  //     customerEphemeralKeySecret: 'sk_test_51Q5iTY06u8jzHB84YFogLCVKL0iLeZuyXFw9JDGkLi6wA8b5AAZsRZX2Ue7O5EL4MxIuVLE8bXeGkv9z7UN53NKH001jxRW3H5',      // от сервера
  //   ),
  // );

  
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        widget.variableCard(widget.card.cardId);
      },
      child: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BrandColor.grey227,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Text(
                  widget.card.cardNumber,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 15,
                    color: BrandColor.grey167,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Expanded(child: SizedBox.shrink()),
                if(widget.isVariable && widget.card.isSaved)Container(
                  child: Row(
                    
                    children: [
                      Text(
                        "CVV: ",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 15,
                          color: BrandColor.black69,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: BrandColor.white,
                          borderRadius: BorderRadius.circular(3)
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          cursorHeight: 20,
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 15,
                            color: BrandColor.black69,
                            fontWeight: FontWeight.w400
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 17),
                            constraints: BoxConstraints(
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 30,),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: BrandColor.blue,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  alignment: Alignment.center,
                  child:widget.isVariable? Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: BrandColor.blue,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ):SizedBox.shrink(),
                )
              ],
            ),
          ),
          /////////////////////////////////////////////отображение ввода
          if(widget.isVariable && !widget.card.isSaved)
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: BrandColor.grey227,
                width: 2
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(horizontal:  20,vertical: 10),
            child: Column(
              children: [
                // CardField(
                  
                //   cursorColor: Colors.amber,
                //   controller: _cardEditController,
                // ),
                // SizedBox(
                //   height: 120,
                //   // width: double.infinity,
                //   child: CardFormField(
                //     controller: _cardFormEditController,
                //     // style: CardFormStyle(
                //     //   // backgroundColor: Colors.amber,
                      
                //     //   backgroundColor: Colors.white,
                //     //   textColor: Colors.black,
                //     //   borderRadius: 13,
                //     //   borderWidth: 1,
                //     //   cursorColor: Colors.black,
                //     // ),
                    
                //     onCardChanged: (details) {
                //       // доступ к полям формы
                //     },
                //   ),
                // ),

                //PaymentButton(),
                SizedBox(height: 10,),
                UIButton(
                  label: "Pay",
                  height: 40,
                  onTap: pay,
                )
              ],
            ),
          )
          //////////////////////////////////////////////
        ],
      ),
    );
  }
}