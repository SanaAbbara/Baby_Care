import 'dart:convert';

import 'package:baby_care/constant/app_urls.dart';
import 'package:baby_care/model/illinesses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IllinessesProvider with ChangeNotifier {
  int? id;
  String? illinessesName, medicineName;
  bool taped = false;
  List<IliinessesModel> _illinesses = [
    // IliinessesModel(
    //     id: 1,
    //     illinessesName: "Canser",
    //     medicineName: ["vetamin", "llll"],
    //     taped: false),
    // IliinessesModel(
    //     id: 2, illinessesName: "Ceart", medicineName: ["dasam"], taped: false),
    // IliinessesModel(
    //     id: 2, illinessesName: "Heart", medicineName: ["dasam"], taped: false),
    // IliinessesModel(
    //     id: 3, illinessesName: "Bb", medicineName: ["mm"], taped: false),
    // IliinessesModel(
    //     id: 4, illinessesName: "Aaas", medicineName: ["aaa"], taped: false),
  ];

  List<IliinessesModel> get illinesses {
    return [..._illinesses];
  }

  List<IliinessesModel> findByIllenssesName(String illinessesname) {
    return _illinesses
        .where((element) => element.illinessesName!.startsWith(illinessesname))
        .toList();
  }

  Future<void> fetchIllinesses(String charName) async {
    final Uri url = Uri.parse(AppUrls.Base_Url + '/illnesse/${charName}');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      print("error in server");
    }
    final responseData = json.decode(response.body);

    List<IliinessesModel> loadeditems = [];
    for (var illnessesData in responseData["Illnesses"]) {
      loadeditems.add(
        IliinessesModel.fromJson(illnessesData),
      );
    }
    _illinesses = loadeditems;
    print(_illinesses);
    notifyListeners();
  }
}
