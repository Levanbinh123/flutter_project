import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget{
  final TextEditingController _textEditingController=TextEditingController();
   MyCurrentLocation({super.key,
  });
  void openLocationSearchBox(BuildContext context){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Your location"),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: "Enter address..",
            ),
          ),
          actions: [
            //cancel
            MaterialButton(onPressed: ()=>Navigator.pop(context),
            child: const Text("Cancel"),
            ),
            MaterialButton(onPressed: (){
            String newAddress=_textEditingController.text;
            context.read<Restaurant>().updateDeliveryAddress(newAddress);
            Navigator.pop(context);
            _textEditingController.clear();
            },
            child: const Text("Save"),)
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver now",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          GestureDetector(
            onTap: ()=>openLocationSearchBox(context),
            child: Row(
              children: [
                //address
                Consumer<Restaurant>
                  (
                    builder: (context, restaurant, child)=>Text(
                        restaurant.deliveryAddress
                  ,style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold
                  ),
                )),
                //drop menu
                Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          )
        ],
      ),
    );
  }
}