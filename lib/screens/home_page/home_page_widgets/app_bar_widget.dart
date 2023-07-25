import 'package:baby_care/constant/app_urls.dart';
import 'package:baby_care/model/user_model.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth/auth.dart';
import '../../login/login_screen.dart';

class AppBarWidget extends StatefulWidget {
  String? image;
  AppBarWidget({Key? key, this.image}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool authdata = false;

  UserModel? userModel;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });
    Future.wait([
      Provider.of<Auth>(context, listen: false).getuserid().then((value) {
        if (value == false) {
          setState(() {
            print("hjghjjh");
            authdata = false;
            loading = false;
          });
        } else {
          Provider.of<Auth>(context, listen: false)
              .getUserInformation(value)
              .then((valuedata) {
            setState(() {
              userModel = valuedata;
              print(userModel!.image!);
              authdata = true;
              loading = false;
            });
          });
        }
      })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: screenWidth / 40, right: screenWidth / 20),
      width: double.maxFinite,
      height: screenHeight / 10.9,
      color: AppColors.mainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screenHeight / 16.8,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: screenHeight / 13.1,
              backgroundImage: authdata
                  ? userModel!.image == ""
                      ? NetworkImage("assets/images/photo4.jpg")
                      : NetworkImage(AppUrls.Base_Url + userModel!.image!)
                  : NetworkImage("assets/images/photo4.jpg"),
            ),
          ),
          Container(
            width: Dimensions.width30 * 3.5,
            child: Row(children: [
              Icon(
                Icons.notifications,
                color: AppColors.iconColor1,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Consumer<Auth>(
                builder: (ctx, auth, _) => InkWell(
                  onTap: () {
                    auth.logout().then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen())));
                  },
                  child: Icon(
                    Icons.logout,
                    color: AppColors.iconColor1,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
