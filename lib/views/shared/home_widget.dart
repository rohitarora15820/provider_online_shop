import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/views/shared/new_shoes.dart';
import 'package:online_shop/views/shared/product_card.dart';

import '../../models/sneaker_model.dart';
import 'appstyle.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.455,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const  CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                }
                else{
                  final male=snapshot.data;
                  return ListView.builder(
              itemCount: male!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final shoes=snapshot.data![index];
                return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(
                      price:"\$${shoes.price}",
                      category:shoes.category,
                      id: shoes.id,
                      name: shoes.name,

                      image:
                          shoes.imageUrl[0],
                    ));
              },
            );
                }

              
            },)
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Shoes",
                      style: appstyle(
                          size: 24,
                          color: Colors.black,
                          fw: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(
                              size: 22,
                              color: Colors.black,
                              fw: FontWeight.bold),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 20,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
                                    SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child:  FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const  CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                }
                else{
                  final male=snapshot.data;
                  return ListView.builder(
              itemCount: male!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final shoes=snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NewShoes(imageUrl: shoes.imageUrl[1]),
                );
              },
            );
                }

              
            },)
          )
        ],
      ),
    );
  }
}


