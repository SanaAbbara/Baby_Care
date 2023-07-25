import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/app_urls.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/provider/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool loading = false;
  int counter = 0;
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });
    Future.wait([
      Provider.of<Auth>(context, listen: false).getuserid().then((valuee) {
        print("dattaa");
        print(valuee);
        Provider.of<Auth>(context, listen: false)
            .getUserInformation(valuee)
            .then((value) {
          setState(() {
            userModel = value;
            loading = false;
            // });
          });
        });
      })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      body: loading
          ? Center(
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: Dimensions.height15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.mainColor,
                          AppColors.mainColor.withOpacity(.4)
                        ],
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: Dimensions.height20 * 5.5,
                      ),
                      CircleAvatar(
                        radius: Dimensions.raduis20 * 3,
                        backgroundImage: userModel!.image == null
                            ? NetworkImage('assets/images/ph2.jpg')
                            : NetworkImage(
                                AppUrls.Base_Url + userModel!.image!),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(userModel!.babyname!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font20,
                          )),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(
                        userModel!.gender!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font15,
                        ),
                      )
                    ]),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Card(
                        margin: EdgeInsets.fromLTRB(
                            Dimensions.width15,
                            Dimensions.height10,
                            Dimensions.width15,
                            Dimensions.height30),
                        child: Container(
                            width: Dimensions.screenWidth - Dimensions.width30,
                            // height:
                            //     Dimensions.height45 * 7 - Dimensions.height20,
                            child: Padding(
                              padding: EdgeInsets.all(Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Information",
                                    style: TextStyle(
                                      fontSize: Dimensions.font26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.man,
                                        color: Colors.blueAccent[400],
                                        size: Dimensions.iconsize16 * 2.18,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "father",
                                            style: TextStyle(
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                          Text(
                                            userModel!.father!,
                                            style: TextStyle(
                                              fontSize: Dimensions.font15 + 2,
                                              color: AppColors.signColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.woman,
                                        color: Colors.yellowAccent[400],
                                        size: Dimensions.iconsize16 * 2.18,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "mother",
                                            style: TextStyle(
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                          Text(
                                            userModel!.mother!,
                                            style: TextStyle(
                                              fontSize: Dimensions.font15 + 2,
                                              color: AppColors.signColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.child_care_outlined,
                                        color: Colors.pinkAccent[400],
                                        size: Dimensions.iconsize16 * 2.18,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "cm_length",
                                            style: TextStyle(
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                          Text(
                                            userModel!.cmLength!,
                                            style: TextStyle(
                                              fontSize: Dimensions.font15 + 2,
                                              color: AppColors.signColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: Colors.lightGreen[400],
                                        size: Dimensions.iconsize16 * 2.18,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "arrangement_among_siblings",
                                            style: TextStyle(
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                          Text(
                                            userModel!
                                                .arrangementAmongSiblings!,
                                            style: TextStyle(
                                              fontSize: Dimensions.font15 + 2,
                                              color: AppColors.signColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  Card(
                      margin: EdgeInsets.fromLTRB(
                          Dimensions.width15,
                          Dimensions.height10,
                          Dimensions.width15,
                          Dimensions.height30),
                      child: Center(
                        child: Container(
                          width: Dimensions.screenWidth - Dimensions.width30,
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.height10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'email',
                                      style: TextStyle(
                                          fontSize: Dimensions.font20),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      userModel!.email!,
                                      style: TextStyle(
                                        color: AppColors.signColor,
                                        fontSize: Dimensions.font15 + 2,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      'Birthday',
                                      style: TextStyle(
                                          fontSize: Dimensions.font20),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      userModel!.birth!,
                                      style: TextStyle(
                                        color: AppColors.signColor,
                                        fontSize: Dimensions.font15 + 2,
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'address',
                                      style: TextStyle(
                                          fontSize: Dimensions.font20),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      userModel!.address!,
                                      style: TextStyle(
                                        color: AppColors.signColor,
                                        fontSize: Dimensions.font15 + 2,
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
