import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/models/constants.dart';
import 'package:online_shop/views/shared/appstyle.dart';

import '../ui/favourite_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _fav_box = Hive.box('fav_box');

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _fav_box.add(addFav);
    getFavourites();
  }

  getFavourites() {
    final favData = _fav_box.keys.map((key) {
      final item = _fav_box.get(key);
      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((e) => e['id']).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image))),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (ids.contains(widget.id)) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return FavouritePage();
                            },
                          ));
                        } else {
                          _createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image
                          });
                        }
                      },
                      child: ids.contains(widget.id)
                          ? const Icon(MaterialCommunityIcons.heart)
                          : Icon(MaterialCommunityIcons.heart_outline),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHt(
                          size: 32,
                          color: Colors.black,
                          fw: FontWeight.bold,
                          ht: 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appstyleWithHt(
                          size: 18,
                          color: Colors.grey,
                          fw: FontWeight.bold,
                          ht: 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appstyle(
                          size: 20, fw: FontWeight.w600, color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appstyle(
                              size: 18,
                              color: Colors.grey,
                              fw: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                          label: const Text(" "),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
