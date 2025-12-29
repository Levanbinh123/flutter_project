
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/pages/delivery_progress_page.dart';

class PaymentPage extends StatefulWidget{
  const PaymentPage({super.key});

  @override
  State<StatefulWidget> createState()=>_PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage>{
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String cardNumber='';
  String expiryDate='';
  String cardHolderName='';
  String cvvCode='';
  bool isCvvFocused=false;
  void userTappedPay(){
    if(formKey.currentState!.validate()){
      //only show dialog is form is valid
      showDialog(
          context: context,
          builder:(context)=>AlertDialog(
            title: const Text("Confirm  payment"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Card Number : $cardNumber"),
                  Text("Expiry Date : $expiryDate"),
                  Text("Card holdername : $cardHolderName"),
                  Text("CVV : $cvvCode"),
                ],
              ),
            ),
            actions: [
              //cancel button

              TextButton(onPressed: ()=>
                  Navigator.pop(context),
                  child: Text("No")),
//yes button
            TextButton(onPressed: ()=>Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>DeliveryProgressPage())),
                child: Text("Yes"))

            ],
          ));
    }
  }
  void onCreditCardModelChange(CreditCardModel data){
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          //credit card
          CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange:(CreditCardBrand brand) {}
          ),
          CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: onCreditCardModelChange,
              formKey: formKey),
          const Spacer(),
          MyButton(ontap: userTappedPay,
              text: "Pay now"),
          const SizedBox(height: 25,)
        ],
      ),
    );
  }
  
}