import 'package:baby_care/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/app_urls.dart';
import '../../../../provider/auth/auth.dart';
import '../../../categoryDetails/food_details.dart';
import '../../../categoryDetails/gallary_photo.dart';
import '../../../categoryDetails/illinesses.dart';
import '../../../categoryDetails/sleep_details.dart';
import '../../../categoryDetails/tips_details.dart';
import '../../../categoryDetails/vaccines_details.dart';
import '../../../../test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  bool isloading = false;
  String? monthData;
  List<Map> categories = Test().categories;
  Future<void> getmonth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    monthData = sharedPreferences.getString(AppUrls.month) ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isloading = true;
    });
    Future.wait([
      getmonth().then((value) {
        if (monthData == "") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          setState(() {
            isloading = false;
          });
        }
      })
    ]);
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   setState(() {
  //     isloading = true;
  //   });
  //   Future.wait([
  //     Provider.of<Auth>(context, listen: false).getusermonth().then((value) {
  //       if (value == "") {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //       } else {
  //         setState(() {
  //           print("hhhhhhhh");
  //           monthData = value;
  //           isloading = false;
  //         });
  //       }
  //     })
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return isloading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: categories.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  if (categories[index]['name'] == "food") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FoodDetails(month: monthData!)));
                  } else if (categories[index]['name'] == "sleep") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SleepDetails(month: monthData!)));
                  } else if (categories[index]['name'] == "illnesses") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Illinesses(month: monthData!)));
                  } else if (categories[index]['name'] == "vaccines") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VaccinesDetails(month: monthData!)));
                  } else if (categories[index]['name'] == "tips") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TipsDetails(month: monthData!)));
                  } else if (categories[index]['name'] == "gallaryPhoto") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GallaryPhotos()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: categories[index]['color'],
                      borderRadius: BorderRadius.circular(screenWidth / 20)),
                  child: GridTile(
                    key: ValueKey(categories[index]['id']),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        categories[index]['image'],
                      ),
                    ),
                    footer: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "\n\n" + categories[index]['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
