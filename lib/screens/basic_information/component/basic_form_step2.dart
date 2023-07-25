import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/screens/basic_information/component/date_piker.dart';
import 'package:baby_care/screens/basic_information/component/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../provider/auth/auth.dart';
import '../../../widgets/default_button.dart';
import '../../home_page/bottom_navbar/bottom_navbar.dart';

class BasicFormStep2 extends StatefulWidget {
  static const routeName = "basicFromStep2";

  @override
  _BasicFormStep2State createState() => _BasicFormStep2State();
}

class _BasicFormStep2State extends State<BasicFormStep2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController babyBirthday = TextEditingController();
  TextEditingController pregnancy = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController lengthInCm = TextEditingController();
  TextEditingController wightInKg = TextEditingController();
  TextEditingController siblings = TextEditingController();
  bool _isLoading = false;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        userModel.birth = babyBirthday.text;
        userModel.pragnancyduration = pregnancy.text;
        userModel.gender = gender.text;
        userModel.cmLength = lengthInCm.text;
        userModel.kgWeight = wightInKg.text;
        userModel.arrangementAmongSiblings = siblings.text;

        print("user model................................\n");

        print(userModel.email.toString() + "\n");
        print(userModel.password.toString() + "\n");
        print(userModel.babyname.toString() + "\n");
        print(userModel.father.toString() + "\n");
        print(userModel.mother.toString() + "\n");
        print(userModel.address.toString() + "\n");
        print(userModel.birth.toString() + "\n");
        print(userModel.pragnancyduration.toString() + "\n");
        print(userModel.cmLength.toString() + "\n");
        print(userModel.kgWeight.toString() + "\n");
        print(userModel.arrangementAmongSiblings.toString() + "\n");
        print(userModel.gender.toString() + "\n");

        print("user model................................\n");

        await Provider.of<Auth>(context, listen: false)
            .signup(userModel)
            .then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } catch (error) {}
    }
    setState(() {
      _isLoading = false;
    });
  }

  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    print("password from step1 page\n" + userModel.address.toString());
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
                height: Dimensions.screenHeight,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.raduis30 * 2),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/ballons.png"))),
              ),
            ),
            Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DatePickerWidget(controller: babyBirthday),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      InputTextWidget(
                          controller: pregnancy,
                          labelText: "Preganancy duration month ",
                          icon: Icons.child_care,
                          obscureText: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      InputTextWidget(
                          controller: gender,
                          labelText: "Baby Gender Male or Female",
                          icon: Icons.child_friendly_sharp,
                          obscureText: false,
                          keyboardType: TextInputType.name),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      InputTextWidget(
                          controller: lengthInCm,
                          labelText: "Length In Cm",
                          obscureText: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      InputTextWidget(
                          controller: wightInKg,
                          labelText: "Weight In Kg",
                          obscureText: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      InputTextWidget(
                          controller: siblings,
                          labelText:
                              "the arrangement of the child among hist sibling",
                          obscureText: false,
                          keyboardType: TextInputType.number),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      _isLoading == false
                          ? DefaultButton(
                              text: "Continue",
                              press: () async {
                                submit();
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: -100,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     width: double.maxFinite,
            //     height: Dimensions.screenHeight / 4,
            //     decoration: BoxDecoration(
            //         borderRadius:
            //             BorderRadius.circular(Dimensions.raduis30 * 2),
            //         image: DecorationImage(
            //             fit: BoxFit.cover,
            //             image: AssetImage("assets/images/ballon.jpg"))),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
