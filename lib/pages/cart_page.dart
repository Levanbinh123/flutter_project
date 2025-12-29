import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/components/my_cart_title.dart';
import 'package:p1/models/restaurant.dart';
import 'package:p1/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget{
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>
      (builder:(context, restaurant, child){
        //cart
      final userCart=restaurant.cart;
      //scaffod ui
      return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
         actions: [
           IconButton(onPressed:(){
             showDialog(context: context,
                 builder: (context)=>AlertDialog(
                   title: const Text("Are you sure you want to clear the cart ? "),
                   actions: [
                     TextButton(
                         onPressed:()=>Navigator.pop(context),
                         child: const Text("Cancel")),
                     TextButton(onPressed: (){
                       Navigator.pop(context);
                       restaurant.clearCart();
                     },
                         child:const Text("Yes") )
                   ],
                 ));
           } ,
               icon: Icon(Icons.delete)
           )
         ],

        ),
        body: Column(
          children: [
                userCart!.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text("Cart is empty..."),
                    )):
                Expanded(
                    child: ListView.builder(
                      itemCount: userCart.length,
                        itemBuilder: (context, index){
                        //get indivitual cart item
                          final cartItem=userCart[index];

                        return MyCartTitle(cartItem: cartItem);}
                        )
                          ),
            MyButton(ontap: ()=>Navigator.push(
              context, MaterialPageRoute(builder: (context)=>const PaymentPage())
            ),
                text: "Go to checkout"),
            const SizedBox(height: 25,)

              ],


        ),

      );
    });
  }
}