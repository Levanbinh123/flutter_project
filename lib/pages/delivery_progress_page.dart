import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/models/restaurant.dart';
import 'package:p1/pages/my_receipt.dart';
import 'package:p1/service/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget{
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  FirestoreService db=FirestoreService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //if we get to this page, submit order to firestore db
    String receipt=context.read<Restaurant>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery in progress..."),
      backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          MyReceipt(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text("Mitch Koko", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary
                    ),),
                    Text("Driver",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ],
                ),
                    const Spacer(),



                    Container(decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        shape: BoxShape.circle
                    ),
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.message),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10,),

                    Container(decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        shape: BoxShape.circle
                    ),
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.call),
                        color: Colors.green,
                      ),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 25,)
        ],
      ),
    );
  }

  //custom botton nav bar
Widget _buildBottonNavbar(BuildContext context){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
        )
      ),
      child: Row(
        children: [
          //profile pic of driver
          Container(decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            shape: BoxShape.circle
          ),
          child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.person)),
          ),
        const SizedBox(width: 10,),
        ],
      ),
    );
}
}