import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.screenHeight / 4,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.raduis30 * 2),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/ballon.jpg"))),
              ),
            ),
            Body(),
          ],
        ),
      ),
    );
  }
}
