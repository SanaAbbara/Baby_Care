import 'dart:convert';

import 'package:baby_care/model/sleep_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_urls.dart';

class SleepProvider with ChangeNotifier {
  String? _sleepDuration;
  String get sleepDuration => _sleepDuration!;
  Future<void> fetchSleep(String month) async {
    print("data data ");
    print(month);

    var request =
        http.Request('GET', Uri.parse(AppUrls.Base_Url + '/sleep/${month}'));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);
    if (response.statusCode != 200) {
      print("error in server");
    }

    _sleepDuration = responseData["sleep"];

    notifyListeners();
  }
}
