
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:online_shop/controllers/mainscreen_provider.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_widget.dart'; 

class BottonNavBar extends StatelessWidget {
  const BottonNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
   return  SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavWidget(
              icon: mainScreenNotifier.pageIndex==0? CommunityMaterialIcons.home:CommunityMaterialIcons.home_outline ,
              onTap: () {
                mainScreenNotifier.pageIndex=0;
              },
            ),
            BottomNavWidget(
              icon:mainScreenNotifier.pageIndex==1? Ionicons.search:Ionicons.search_outline,
              onTap: () {
                mainScreenNotifier.pageIndex=1;
              },
            ),
            BottomNavWidget(
               icon:mainScreenNotifier.pageIndex==2? Ionicons.heart:MaterialCommunityIcons.heart_circle_outline,
              onTap: () {
                mainScreenNotifier.pageIndex=2;
              },
            ),
            BottomNavWidget(
              icon:mainScreenNotifier.pageIndex==3? Ionicons.cart:Ionicons.cart_outline,
              onTap: () {
                mainScreenNotifier.pageIndex=3;
              },
            ),
            BottomNavWidget(
               icon:mainScreenNotifier.pageIndex==4? Ionicons.person:Ionicons.person_outline,
              onTap: () {
                mainScreenNotifier.pageIndex=4;
              },
            ),
          ],
        ),
      ),
    ));
       
      },
    );
  }
}