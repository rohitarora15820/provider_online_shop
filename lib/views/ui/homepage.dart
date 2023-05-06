import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/sneaker_model.dart';
import '../../services/helper.dart';
import '../shared/appstyle.dart';
import '../shared/home_widget.dart';
import '../shared/new_shoes.dart';
import '../shared/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

      late Future<List<Sneakers>> _male;
      late Future<List<Sneakers>> _female;
      late Future<List<Sneakers>> _kids;


      void getMale(){
        _male=Helper().getMaleSneakers();
      }

       void getFeMale(){
        _female=Helper().getFeMaleSneakers();
      }

       void getKids(){
        _kids=Helper().getkidsSneakers();
      }


      @override
  void initState() {

    super.initState();
    getMale();
    getFeMale();
    getKids();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe2e2e2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top_image.png'),
                      fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.only(left: 8, bottom: 18),
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Athletics Shoes",
                          style: appstyleWithHt(
                              size: 42,
                              color: Colors.white,
                              fw: FontWeight.bold,
                              ht: 1.5)),
                      Text("Collection",
                          style: appstyleWithHt(
                              size: 42,
                              color: Colors.white,
                              fw: FontWeight.bold,
                              ht: 1.2)),
                      TabBar(
                        padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle: appstyle(
                              size: 24,
                              color: Colors.white,
                              fw: FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(
                              text: "Mens Shoes",
                            ),
                            Tab(
                              text: "Women Shoes",
                            ),
                            Tab(
                              text: "Kids Shoes",
                            ),
                          ])
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.265),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(male: _male),
                      HomeWidget(male: _female),
                        HomeWidget(male: _kids),
                  
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}

