import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/screens/basic_information/component/basic_form_step2.dart';
import 'package:baby_care/screens/basic_information/component/input_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/form_error.dart';

// ignore: must_be_immutable
class BasicFormStep1 extends StatefulWidget {
  UserModel userModelData;
  BasicFormStep1({required this.userModelData});
  @override
  _BasicFormStep1State createState() => _BasicFormStep1State();
}

class _BasicFormStep1State extends State<BasicFormStep1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController babyName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController address = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.screenHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.raduis30 * 2),
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
                  //  SizedBox(height: getProportionateScreenHeight(200)),
                  InputTextWidget(
                      controller: babyName,
                      labelText: "babyName",
                      icon: Icons.child_care,
                      obscureText: false,
                      keyboardType: TextInputType.name),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  InputTextWidget(
                      controller: fatherName,
                      labelText: "Father Name",
                      icon: Icons.person,
                      obscureText: false,
                      keyboardType: TextInputType.name),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  InputTextWidget(
                      controller: motherName,
                      labelText: "Mother Name",
                      icon: Icons.woman,
                      obscureText: false,
                      keyboardType: TextInputType.name),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  InputTextWidget(
                      controller: address,
                      labelText: "Address",
                      icon: Icons.location_city,
                      obscureText: false,
                      keyboardType: TextInputType.name),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  DefaultButton(
                    text: "Continue",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        widget.userModelData.babyname = babyName.text;
                        widget.userModelData.father = fatherName.text;
                        widget.userModelData.mother = motherName.text;
                        widget.userModelData.address = address.text;
                        // if all are valid then go to success screen
                        Navigator.pushNamed(context, BasicFormStep2.routeName,
                            arguments: widget.userModelData);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Positioned(
        //     bottom: -20,
        //     left: 0,
        //     right: 0,
        //     child: Container(
        //       width: double.maxFinite,
        //       height: Dimensions.screenHeight / 4,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(Dimensions.raduis30 * 2),
        //           image: DecorationImage(
        //               fit: BoxFit.cover,
        //               image: AssetImage("assets/images/ballon.jpg"))),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
