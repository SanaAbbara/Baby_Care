// import 'dart:convert';

// import 'package:baby_care/constant/app_urls.dart';
// import 'package:baby_care/model/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// // class UserModelProvider with ChangeNotifier {
// //   String? email;
// //   String? password;
// //   String? babyname;
// //   String? father;
// //   String? mother;
// //   String? address;
// //   String? birth;
// //   String? pragnancyduration;
// //   String? gender;
// //   String? cmLength;
// //   String? kgWeight;
// //   String? arrangementAmongSiblings;
// //   List<UserModel> _users = [];

// //   List<UserModel> get users {
// //     return [..._users];
// //   }
// // }

// class Auth with ChangeNotifier {
//   String? _ownerId;

//   String get ownerId {
//     return _ownerId!;
//   }

//   bool get isAuth {
//     return ownerId.isNotEmpty;
//   }

//   Future<void> signup(UserModel userModel) async {
//     const url = AppUrls.Base_Url + 'signup';
//     Uri uri = Uri.parse(url);
//     final response = await http.post(
//       uri,
//       body: json.encode({
//         'email': userModel.email,
//         'password': userModel.password,
//         'babyname': userModel.babyname,
//         'father': userModel.father,
//         'mother': userModel.mother,
//         'address': userModel.address,
//         'birth': userModel.birth,
//         'pragnancyduration': userModel.pragnancyduration,
//         'gender': userModel.gender,
//         'cmLength': userModel.cmLength,
//         'kgWeight': userModel.kgWeight,
//         'arrangementAmongSiblings': userModel.arrangementAmongSiblings,
//       }),
//     );
//     if (response.statusCode == 201) {
//       print(' your account is active ');
//     }
//     final responseData = json.decode(response.body);

//     _ownerId = responseData['id'];

//     print(_ownerId);
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     final userAuthData = json.encode({
//       'ownerId': _ownerId,
//     });

//     prefs.setString('userAuthData', userAuthData);
//   }

//   Future<void> login(String email, String password) async {
//     const url = "";
//     Uri uri = Uri.parse(url);

//     final response = await http.post(
//       uri,
//       body: json.encode({
//         'email': email,
//         'password': password,
//       }),
//     );
//     final responseData = json.decode(response.body);

//     _ownerId = responseData['id'];

//     print(_ownerId);
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     final userAuthData = json.encode({
//       'ownerId': _ownerId,
//     });

//     prefs.setString('userAuthData', userAuthData);
//   }

//   Future<bool> tryAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userAuthData')) {
//       // so there is no data stored on the user
//       // no valid token
//       return false;
//     }
//     final extractedUserData =
//         json.decode(prefs.getString('userAuthData')!) as Map<String, dynamic>;
//     _ownerId = extractedUserData['ownerId'];
//     notifyListeners();
//     return true;
//   }

//   Future<void> logout() async {
//     _ownerId = null;
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('userAuthData');
//   }
// }
