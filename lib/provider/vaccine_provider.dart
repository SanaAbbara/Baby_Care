import 'dart:convert';

import 'package:baby_care/constant/app_urls.dart';
import 'package:baby_care/model/vaccine.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VaccineProvider with ChangeNotifier {
  String? vaccineName;
  int? doseNum;
  bool? taken;
  String? deadLine;

  List<Vaccine> _vaccines = [];

  List<Vaccine> get vaccines {
    return [..._vaccines];
  }

  Future<void> fetchVaccine(String month) async {
    var request =
        http.Request('GET', Uri.parse(AppUrls.Base_Url + '/vaccine/${month}'));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);
    if (response.statusCode != 200) {
      print("error in server");
    }
    List<Vaccine> loadeditems = [];
    for (var foodData in responseData["vaccines"]) {
      loadeditems.add(
        Vaccine.fromJson(foodData),
      );
    }
    _vaccines = loadeditems;
    notifyListeners();
  }

  Future<void> checkvaccine(String userid, String vaccinid) async {
    print(userid);
    print(vaccinid);
    var request = http.Request('GET',
        Uri.parse(AppUrls.Base_Url + '/check_vaccine/${userid}/${vaccinid}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }
}
