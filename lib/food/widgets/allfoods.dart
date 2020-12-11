import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class AllFoods {

  final String name;
  final String price;
  final String image;
  final String weight;
  final String description;

  AllFoods({this.description, this.image, this.name, this.price, this.weight});
}

List<AllFoods> AllFoodList = [
  AllFoods(
    name: "جوج",
    price: "15000",
    weight: "400 - 800",
    image: "assets/joojeh.png",
    description:
    "Soft, sweet and delicious, the apple is a popular choice for breakfast, snacks or any time of the day. The vibrant yellow peel provides natural protection while storing, and is a great indicator of when the fruit is reade to eat!",
  ),
  AllFoods(
    name: "میکس",
    price: "20000",
    weight: "400 - 800",
    image: "assets/mix.png",
    description:
    "Soft, sweet and delicious, the Banana is a popular choice for breakfast, snacks or any time of the day. The vibrant yellow peel provides natural protection while storing, and is a great indicator of when the fruit is reade to eat!",
  ),
  AllFoods(
    name: "قیمه",
    price: "10000",
    weight: "400 - 800",
    image: "assets/gheyme.png",
    description:
    "Soft, sweet and delicious, the mango is a popular choice for breakfast, snacks or any time of the day. The vibrant yellow peel provides natural protection while storing, and is a great indicator of when the fruit is reade to eat!",
  ),
  AllFoods(
    name: "قورمه",
    price: "12000",
    weight: "400 - 800",
    image: "assets/ghormeh.png",
    description:
    "Soft, sweet and delicious, the pineapple is a popular choice for breakfast, snacks or any time of the day. The vibrant yellow peel provides natural protection while storing, and is a great indicator of when the fruit is reade to eat!",
  ),
  AllFoods(
    name: "چلو کباب",
    price: "12000",
    weight: "400 - 800",
    image: "assets/kabab.png",
    description:
    "Soft, sweet and delicious, the strawberry is a popular choice for breakfast, snacks or any time of the day. The vibrant yellow peel provides natural protection while storing, and is a great indicator of when the fruit is reade to eat!",
  ),
];
