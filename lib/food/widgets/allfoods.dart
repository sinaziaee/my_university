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

