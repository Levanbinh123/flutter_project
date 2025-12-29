import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:p1/models/cart_item.dart';
import 'package:p1/models/food.dart';

class Restaurant extends ChangeNotifier{
  final List<Food> _menu = [
    //burgers
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce,tomato,"
          "and hint of onion and pickle",
      imagePath: "lib/images/burgers/burger.jpg",
      price: 0.99,
      availableAddons:
      [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99)
      ],
      category:  FoodCategory.bugers,
    ),
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce,tomato,"
          "and hint of onion and pickle",
      imagePath: "lib/images/burgers/burger.jpg",
      price: 0.99,
      availableAddons:
      [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99)
      ],
      category:  FoodCategory.bugers,
    ),
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce,tomato,"
          "and hint of onion and pickle",
      imagePath: "lib/images/burgers/burger.jpg",
      price: 0.99,
      availableAddons:
      [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99)
      ],
      category:  FoodCategory.bugers,
    ),
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce,tomato,"
          "and hint of onion and pickle",
      imagePath: "lib/images/burgers/burger.jpg",
      price: 0.99,
      availableAddons:
      [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99)
      ],
      category:  FoodCategory.bugers,
    ),
    Food(
      name: "Classic Cheeseburger",
      description: "A juicy beef patty with melted cheddar, lettuce,tomato,"
          "and hint of onion and pickle",
      imagePath: "lib/images/burgers/burger.jpg",
      price: 0.99,
      availableAddons:
      [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99)
      ],
      category:  FoodCategory.bugers,
    ),
  ];
  final List<CartItem>_cart=[];
  late String _deliveryAddress='99 Ho';
  String get deliveryAddress=>_deliveryAddress;
  List<Food> get menu =>_menu;
  List<CartItem> get cart=>_cart;
  //user cart

  //add to cart
void addToCart(Food food, List<Addon> selectedAddon){
  CartItem? cartItem=_cart.firstWhereOrNull((item)
  {
    //check if the food items are the same
    bool isSameFood=item.food==food;
    //check if the list of selected addons are the same
    bool isSameAddons=ListEquality().equals(item.selectedAddons, selectedAddon);
    return isSameFood&&isSameAddons;
  });
  if(cartItem!=null){
    cartItem.quantity++;
  }
  //other wise, add a new cart iten to the cart
  else{
    _cart.add(
      CartItem(food: food,
          selectedAddons: selectedAddon)
    );
  }
notifyListeners();

}

//remove from cart
void removeFromCart(CartItem cartItem){
  int cartIndex=_cart.indexOf(cartItem);
  if(cartIndex!=-1){
    if(_cart[cartIndex].quantity>1){
      _cart[cartIndex].quantity--;
    }
    else{
      _cart.removeAt(cartIndex);
    }
  }
  notifyListeners();
}


//get total price of cart

double getTotalPrice(){
  double total=0.0;
  for(CartItem  cartItem in _cart){
    double itemTotal=cartItem.food.price;
    for(Addon addon in cartItem.selectedAddons){
      itemTotal+=addon.price;
    }
    total+=itemTotal*cartItem.quantity;
  }
  return total;
}
//get total number of items in cart

  int getTotalItemCount(){
  int totalItemCount=0;
  for(CartItem cartItem in _cart){
    totalItemCount+=cartItem.quantity;
  }
  return totalItemCount;
  }
//clear cart
void clearCart(){
  _cart.clear();
  notifyListeners();
}
//update delivery address
  void updateDeliveryAddress(String newAddress){
  _deliveryAddress=newAddress;
  notifyListeners();
  }

//generate a receipt
String displayCartReceipt(){
  final receipt=StringBuffer();
  receipt.writeln("Here's your receipt");
  receipt.writeln();
  //format the date to include to secounds only
  String formattedDate=DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  receipt.writeln(formattedDate);
  receipt.writeln();
  receipt.writeln("---------");
  for(final cartItem in _cart){
    receipt.writeln("${cartItem.quantity} x ${cartItem.food.name}-${_formatPrice(cartItem.food.price)}");
    if(cartItem.selectedAddons.isNotEmpty){
      receipt.writeln(" Add-ons:${_formatAddons(cartItem.selectedAddons)}");
    }
    receipt.writeln();
  }
  receipt.writeln("---------------");
  receipt.writeln();
  receipt.writeln("Total Items: ${getTotalItemCount()}");
  receipt.writeln("Total Price : ${_formatPrice(getTotalPrice())}");
  receipt.writeln("Delivering to: $deliveryAddress");
  return receipt.toString();
}



///format double value into money

  String _formatPrice(double price){
    return "\$${price.toStringAsFixed(2)}";
  }

//format list of addons into a string summary
String _formatAddons(List<Addon> addons){
  return addons.map((addons)=>"${addons.name}(${_formatPrice(addons.price)})").join(", ");
}
}
