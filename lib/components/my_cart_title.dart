import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/my_quantity_selecter.dart';
import 'package:p1/models/cart_item.dart';
import 'package:p1/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTitle extends StatelessWidget{
  final CartItem cartItem;
  const MyCartTitle({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>
      (builder: (context,restaurant, child)=>Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          //food
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //food image
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                  
                    borderRadius: BorderRadius.circular(8),
                      child: Image.asset(cartItem.food.imagePath,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //food name
                    Text(cartItem.food.name),
                    Text('\$${cartItem.food.price}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    ),
                    ),
                  ],
                ),
                const Spacer(),
                MyQuantitySelecter(
                    food: cartItem.food,
                    onDecrement: (){
                      restaurant.removeFromCart(cartItem);
                    },
                    onIncrement: (){
                      restaurant.addToCart(cartItem.food,
                          cartItem.selectedAddons);
                    },
                    quantity: cartItem.quantity)
                //name and price


                //increment or decrement quantity
              ],
            ),
          ),

          //addons
          SizedBox(
            height: cartItem.selectedAddons.isEmpty?0:60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
              children: cartItem.selectedAddons.map((addon)=>
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                    label: Row(
                      children: [
                        //addon name
                        Text(addon.name),
                        //addin price
                        Text('(\$${addon.price})')
                      ],
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                      )
                    ),
                    onSelected: (value){
                
                    },
                backgroundColor: Theme.of(context).colorScheme.secondary,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 12
                  ),
                ),
              )
              ).toList(),
            ),
          )
        ],
      ),
    ));
  }
  
}