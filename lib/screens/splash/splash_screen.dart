import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    Dimensions().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
