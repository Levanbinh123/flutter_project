import 'package:flutter/material.dart';
import 'package:p1/components/my_button.dart';
import 'package:p1/models/food.dart';
import 'package:p1/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;

  const FoodPage({
    super.key,
    required this.food,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late Map<Addon, bool> selectedAddons={};
  void  addToCart(Food food, selectedAddons){
    //close the current food page to go back to menu
    Navigator.pop(context);
    //format the selected addons
    List<Addon> currentlySelectedAddons=[];
    for(Addon addon in widget.food.availableAddons){
      if(selectedAddons[addon]==true){
        currentlySelectedAddons.add(addon);

      }
    }
    //add to cart
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  void initState() {
    super.initState();

      for (final addon in widget.food.availableAddons) {
        selectedAddons[addon]=false;
      }
    }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ===== MAIN UI =====
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food image
                Image.asset(
                  widget.food.imagePath,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // food name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // price
                      Text(
                        '\$${widget.food.price}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // description
                      Text(
                        widget.food.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),

                      // addons title
                      Text(
                        "Add-ons",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // addons list
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount:
                          widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            final addon =
                            widget.food.availableAddons[index];

                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '\$${addon.price}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                              ),
                              value:
                              selectedAddons[addon] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddons[addon] =
                                      value ?? false;
                                });
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // add to cart button
                      MyButton(
                        ontap: () =>addToCart(widget.food, selectedAddons),
                        text: "Add to cart",
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ===== BACK BUTTON =====
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
