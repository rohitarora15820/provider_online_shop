


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartNotifier extends ChangeNotifier{
  int _counter=0;

  int get counter=>_counter;
final cartBox=Hive.box('cart_box');
  List<dynamic> _cart = [];

  List<dynamic> get cart=>_cart;

  set cart(List<dynamic> newCart){

_cart=newCart;
    notifyListeners();
  }


  getCart(){
        
    final cartData = cartBox.keys.map((key) {
      final item = cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes'],
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }

  void increment(){
    _counter++;
    notifyListeners();
  }

  void decrement(){
  if(_counter>=1){
    _counter--;
    notifyListeners();
  }
  
  }

Future deleteCart(int key)async{
  await cartBox.delete(key);

}
}