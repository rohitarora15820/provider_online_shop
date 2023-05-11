import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:online_shop/views/mainscreen.dart';
import 'package:online_shop/views/shared/appstyle.dart';

import '../../models/constants.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final _fav_box = Hive.box('fav_box');

  deleteFav(int key) async {
    await _fav_box.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _fav = [];
    final favData = _fav_box.keys.map(
      (e) {
        final item = _fav_box.get(e);
        return {
          "key": e,
          "id": item['id'],
          "name": item['name'],
          "category": item['category'],
          "price": item['price'],
          "imageUrl": item['imageUrl'],
        };
      },
    ).toList();

    _fav = favData.reversed.toList();

    return Scaffold(
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.png"),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Favourites",
                    style: appstyle(
                      size: 40,
                      color: Colors.white,
                      fw: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: _fav.length,
                  padding: EdgeInsets.only(top: 100),
                  itemBuilder: (context, index) {
                    final shoe = _fav[index];

                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1))
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: CachedNetworkImage(
                                        imageUrl: shoe['imageUrl'],
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
                                            shoe['name'],
                                            style: appstyle(
                                                size: 16,
                                                color: Colors.black,
                                                fw: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            shoe['category'],
                                            style: appstyle(
                                                size: 14,
                                                color: Colors.black,
                                                fw: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                shoe['price'],
                                                style: appstyle(
                                                    size: 18,
                                                    color: Colors.black,
                                                    fw: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      deleteFav(shoe['key']);
                                      ids.removeWhere((element) => element == shoe['id']);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
                                    },
                                    child: Icon(Ionicons.heart_dislike),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ])));
  }
}
