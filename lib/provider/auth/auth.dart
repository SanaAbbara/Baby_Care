import 'package:baby_care/constant/app_urls.dart';
import 'package:baby_care/model/user_model.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? monthdata;
  String? userid;
  int firstSign = 0;
  int get firstsign {
    return firstSign;
  }

  String get month {
    return monthdata!;
  }

  String get userId {
    return userid!;
  }

  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  bool get isAuth {
    return monthdata != "" && userid != "";
  }

  Future<void> signup(UserModel userModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse(AppUrls.Base_Url + '/register'));
    request.body = json.encode({
      "email": userModel.email,
      "password": userModel.password,
      "babyname": userModel.babyname,
      "father": userModel.father,
      "mother": userModel.mother,
      "address": userModel.address,
      "birth": userModel.birth,
      "pragnancyduration": userModel.pragnancyduration,
      "gender": userModel.gender,
      "cm_length": userModel.cmLength,
      "kg_weight": userModel.kgWeight,
      "arrangement_among_siblings": userModel.arrangementAmongSiblings,
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppUrls.userid, responseData['data']['id'].toString());
    prefs.setString(
        AppUrls.month, responseData['data']['age_in_months'].toString());

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    print("login page " + email);
    var headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse(AppUrls.Base_Url + '/signin');

    final response = await http.post(url,
        headers: headers,
        body:
            json.encode({"email": email.trim(), "password": password.trim()}));

    if (response.statusCode != 200) {
      print("error");
    }
    Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppUrls.userid, responseData['data']['id'].toString());
    prefs.setString(
        AppUrls.month, responseData['data']['age_in_months'].toString());
    notifyListeners();
  }

  Future<String> getuserid() async {
    String userdataid;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdataid = sharedPreferences.getString(AppUrls.userid) ?? "";
    notifyListeners();
    return userdataid;
  }

  Future<String> getusermonth() async {
    String monthdatauser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    monthdatauser = sharedPreferences.getString(AppUrls.month) ?? "";

    return monthdatauser;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(AppUrls.userid) == "") {
      // so there is no data stored on the user
      // no valid token
      return false;
    }

    monthdata = prefs.getString(AppUrls.month)!;
    userid = prefs.getString(AppUrls.userid)!;
    print(userid);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    monthdata = "";
    userid = "";
    firstSign = 1;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AppUrls.userid);
    prefs.remove(AppUrls.month);
  }

  Future<UserModel> getUserInformation(String userid) async {
    UserModel? userModel;
    var request =
        http.Request('GET', Uri.parse(AppUrls.Base_Url + '/profile/${userid}'));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(responseData['data']);
    } else {
      print(response.reasonPhrase);
    }
    print("object");
    print(userModel);
    notifyListeners();
    return userModel!;
  }
}
