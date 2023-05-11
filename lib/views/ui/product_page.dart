import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/controllers/cart_provider.dart';
import 'package:online_shop/controllers/favourite_provider.dart';
import 'package:provider/provider.dart';

import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/services/helper.dart';

import '../../models/constants.dart';
import '../../models/sneaker_model.dart';
import '../shared/appstyle.dart';
import '../shared/checkout_btn.dart';
import 'favourite_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    required this.id,
    required this.category,
  }) : super(key: key);

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override


  final PageController _pageController = PageController();



 

 



  @override
  Widget build(BuildContext context) {
      var productProvider=Provider.of<ProductNotifier>(context);
      productProvider.getShoes(widget.category, widget.id);
    var cartProvider=Provider.of<CartNotifier>(context);

    var favoriteNotifier=Provider.of<FavouriteNotifier>(context,listen:true);
   favoriteNotifier.getFavourites();
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future:productProvider.sneakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data;
                return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      productNotifier.shoeSizes.clear();
                                    },
                                    child: const Icon(Icons.close,
                                        color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                        Ionicons.ellipsis_horizontal,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: MediaQuery.of(context).size.height,
                          flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: _pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activepage = page;
                                  },
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker!.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            right: 20,
                                            child: Consumer<FavouriteNotifier>(
                                              builder: (context, favouriteNotifier,child) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    if (
                                                      favouriteNotifier.
                                                      ids
                                                        .contains(widget.id)) {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) {
                                                          return FavouritePage();
                                                        },
                                                      ));
                                                    } else {
                                                      favoriteNotifier.createFav({
                                                        "id": sneaker.id,
                                                        "name": sneaker.name,
                                                        "category":
                                                            sneaker.category,
                                                        "price": sneaker.price,
                                                        "imageUrl":
                                                            sneaker.imageUrl[0]
                                                      });
                                                    }
                                                    setState(() {
                                                      
                                                    });

                                                  },
                                                  child: favouriteNotifier.ids.contains(widget.id)
                                                      ? Icon(AntDesign.heart)
                                                      : const Icon(
                                                          AntDesign.hearto,
                                                          color: Colors.grey,
                                                        ),
                                                );
                                              },
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 4),
                                                        child: CircleAvatar(
                                                            radius: 8,
                                                            backgroundColor:
                                                                productNotifier
                                                                            .activepage !=
                                                                        index
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black),
                                                      ))),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.645,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appstyle(
                                                size: 40,
                                                color: Colors.black,
                                                fw: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appstyle(
                                                    size: 20,
                                                    color: Colors.grey,
                                                    fw: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appstyle(
                                                    size: 26,
                                                    color: Colors.black,
                                                    fw: FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text("Colors",
                                                      style: appstyle(
                                                          size: 26,
                                                          color: Colors.black,
                                                          fw: FontWeight.w500)),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.orange,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Select sizes",
                                                      style: appstyle(
                                                          size: 20,
                                                          color: Colors.black,
                                                          fw: FontWeight.w600)),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("View size guide",
                                                      style: appstyle(
                                                          size: 20,
                                                          color: Colors.grey,
                                                          fw: FontWeight.w500)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                  itemCount: productNotifier
                                                      .shoeSizes.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes =
                                                        productNotifier
                                                            .shoeSizes[index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid)),
                                                        disabledColor:
                                                            Colors.white,
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appstyle(
                                                              size: 18,
                                                              color: sizes[
                                                                      'isSelected']
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fw: FontWeight
                                                                  .w500),
                                                        ),
                                                        selectedColor:
                                                            Colors.black,
                                                        selected:
                                                            sizes['isSelected'],
                                                        onSelected: (newValue) {
                                                          if (productNotifier
                                                              .sizes
                                                              .contains(sizes[
                                                                  'size'])) {
                                                            productNotifier
                                                                .sizes
                                                                .remove(sizes[
                                                                    'size']);
                                                          } else {
                                                            productNotifier
                                                                .sizes
                                                                .add(sizes[
                                                                    'size']);
                                                          }
                                                          log(productNotifier
                                                              .sizes
                                                              .toString());

                                                          productNotifier
                                                              .toggleCheck(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              sneaker.title,
                                              maxLines: 2,
                                              style: appstyle(
                                                  size: 26,
                                                  color: Colors.black,
                                                  fw: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            sneaker.description,
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                            style: appstyle(
                                                size: 14,
                                                color: Colors.black,
                                                fw: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: CheckoutButton(
                                                label: "Add to Cart",
                                                onTap: () async {
                                               productProvider.createCart({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category":
                                                        sneaker.category,
                                                    "sizes":
                                                        productNotifier.sizes[0],
                                                    "imageUrl":
                                                        sneaker.imageUrl[0],
                                                    "price": sneaker.price,
                                                    "qty": 1
                                                  });
                                                  productNotifier.sizes.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}
