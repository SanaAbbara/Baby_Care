import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/screens/login/login_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight * 0.12), //
                Text("Login Page",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    )),
                Text(
                  "Enter your details or \n go to Sign up page for add new Account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Dimensions.screenHeight * 0.08),
                LoginForm(),
                SizedBox(height: Dimensions.screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
