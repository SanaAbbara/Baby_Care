import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/screens/basic_information/component/basic_form_step1.dart';
import 'package:flutter/material.dart';

import '../../../constant/Dimensions/domensions.dart';

class BasicInformation extends StatefulWidget {
  static const routeName = "basicInformation";
  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  StepperType stepperType = StepperType.vertical;
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    print("password from signup page\n" + userModel.password.toString());
    Dimensions().init(context);
    return Scaffold(body: BasicFormStep1(userModelData: userModel));
  }
}
