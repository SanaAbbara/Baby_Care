import 'dart:convert';

import 'package:baby_care/model/tips_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_urls.dart';

class TipsProvider with ChangeNotifier {
  String? title;
  String? subTitle;
  List<TipsModel> _tipsData = [];

  List<TipsModel> get tipsData {
    return [..._tipsData];
  }

  Future<void> fetchTips(String month) async {
    var request =
        http.Request('GET', Uri.parse(AppUrls.Base_Url + '/tips/${month}'));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);

    List<TipsModel> loadeditems = [];
    for (var foodData in responseData["tips"]) {
      loadeditems.add(
        TipsModel.fromJson(foodData),
      );
    }

    _tipsData = loadeditems;
    notifyListeners();
  }
}
