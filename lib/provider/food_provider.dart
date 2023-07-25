import 'dart:convert';

import 'package:baby_care/model/foodModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_urls.dart';

class FoodProvider with ChangeNotifier {
  String? milk;
  List<String>? fruits;
  List<String>? vegetable;
  List<String>? creamy;
  List<String>? carbohydrates;
  String? water;
  List<FoodModel> _foodData = [];

  List<FoodModel> get foodData {
    return [..._foodData];
  }

  Future<void> fetchFood(String month) async {
    var request =
        http.Request('GET', Uri.parse(AppUrls.Base_Url + '/feed/${month}'));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);

    List<FoodModel> loadeditems = [];
    for (var foodData in responseData["food"]) {
      loadeditems.add(
        FoodModel.fromJson(foodData),
      );
    }

    _foodData = loadeditems;
    notifyListeners();
  }
}
