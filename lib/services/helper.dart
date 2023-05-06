import 'package:flutter/services.dart' as the_bundle;

import '../models/sneaker_model.dart';


class Helper{
Future <List<Sneakers>>  getMaleSneakers() async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
  final maleList=sneakersFromJson(data);
  return maleList; 

}

Future <List<Sneakers>>  getFeMaleSneakers() async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
  final femaleList=sneakersFromJson(data);
  return femaleList; 

}
Future <List<Sneakers>>  getkidsSneakers() async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
  final kidsList=sneakersFromJson(data);
  return kidsList; 

}

Future <Sneakers>  getMaleSneakersById(String id) async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
  final maleList=sneakersFromJson(data);

  final sneaker=maleList.firstWhere((element) => element.id == id);

  return sneaker; 

}


Future <Sneakers>  getFeMaleSneakersById(String id) async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
  final femaleList=sneakersFromJson(data);

  final sneaker=femaleList.firstWhere((element) => element.id == id);

  return sneaker; 

}

Future <Sneakers>  getKidsSneakersById(String id) async
{
  final data=await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
  final kidsList=sneakersFromJson(data);

  final sneaker=kidsList.firstWhere((element) => element.id == id);

  return sneaker; 

}
}