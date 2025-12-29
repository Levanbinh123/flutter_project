import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/models/food.dart';

class MyFoodTitle extends StatelessWidget{
  final Food food;
  final void Function()? onTap;
  const MyFoodTitle({super.key,
    required this.food,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Text(food.name),
                          Text('\$${food.price}'
                          ,style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(food.description, style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),),
                          Text(food.description),
                        ],
                      )),
                  //food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        food.imagePath,

                        height: 120,)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
          const Divider(
            indent: 25,
            endIndent: 25,
          )
        ],
      );
  }
  
}