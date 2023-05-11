import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/sneaker_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];
  
  final cartBox=Hive.box('cart_box');



  int get activepage => _activepage;

  set activepage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoeSizes(List<dynamic> newSIze) {
    _shoeSizes = newSIze;
    notifyListeners();
  }

  //toggle Selection
  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

   late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
    late Future<Sneakers> sneakers;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFeMaleSneakers();
  }

  void getkids() {
    kids = Helper().getkidsSneakers();
  }

   void getShoes(String category,String id) {
    if (category == "Men's Running") {
      sneakers = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneakers = Helper().getFeMaleSneakersById(id);
    } else {
      sneakers = Helper().getKidsSneakersById(id);
    }
  }

   Future createCart(Map<String, dynamic> newCart) async {
    await cartBox.add(newCart);
  }

}
