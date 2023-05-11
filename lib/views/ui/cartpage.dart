import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

import '../shared/appstyle.dart';
import '../shared/checkout_btn.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
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

    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: Color(0xffe2e2e2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(
                      size: 36, color: Colors.black, fw: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {},
                                    flex: 1,
                                    backgroundColor: Color(0xff000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ]),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3)
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: data['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: appstyle(
                                                    size: 16,
                                                    color: Colors.black,
                                                    fw: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data['category'],
                                                style: appstyle(
                                                    size: 14,
                                                    color: Colors.black,
                                                    fw: FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data['price'],
                                                    style: appstyle(
                                                        size: 18,
                                                        color: Colors.black,
                                                        fw: FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("Size",
                                                      style: appstyle(
                                                          size: 18,
                                                          color: Colors.black,
                                                          fw: FontWeight.w600)),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("${data['sizes']}",
                                                      style: appstyle(
                                                          size: 18,
                                                          color: Colors.black,
                                                          fw: FontWeight.w600)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                 ,Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(16))

                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){},
                                            child: Icon(AntDesign.minussquare,size:20,color: Colors.grey,),


                                          ),
                                          Text(data['qty'].toString(),
                                          style: appstyle(size: 16, color: Colors.black, fw: FontWeight.w600),

                                          ),                                  InkWell(
                                            onTap: (){},
                                            child: Icon(AntDesign.plussquare,size:20,color: Colors.grey,),


                                          ),
                                        ],
                                      ),
                                    ),
                                    )
                                  ],
                                 )
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Align(alignment: Alignment.bottomCenter,
            
            child: CheckoutButton(

              label: "Proceed to Checkout",
            ),)
          ],
        ),
      ),
    );
  }
}
