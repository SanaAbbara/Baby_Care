import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, this.text, this.image, this.discription})
      : super(key: key);
  final String? text, image, discription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())),
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height20),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "Skip",
                style: TextStyle(
                    color: AppColors.mainColor, fontSize: Dimensions.font26),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Image.asset(
          image!,
          height: Dimensions.screenHeight / 1.8,
          width: double.maxFinite,
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Dimensions.font20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.width10),
          child: Text(
            discription!,
            style: TextStyle(
              fontSize: Dimensions.font15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
