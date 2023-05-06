
import 'package:flutter/material.dart';

import 'package:online_shop/controllers/mainscreen_provider.dart';

import 'package:online_shop/views/shared/botton_nav.dart';
import 'package:online_shop/views/shared/product_by_cat.dart';
import 'package:online_shop/views/ui/cartpage.dart';
import 'package:online_shop/views/ui/homepage.dart';
import 'package:online_shop/views/ui/profilepage.dart';
import 'package:online_shop/views/ui/searchpage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  
  List<Widget> pageList=const [
    HomePage(),
    SearchPage(),
   ProductByCat(),
    CartPage(),
    ProfilePage()
  ];
   MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xffe2e2e2),
         body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar:const  BottonNavBar(),
       );
      },
      
    );
  }
}


