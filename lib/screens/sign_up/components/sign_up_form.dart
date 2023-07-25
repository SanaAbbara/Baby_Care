import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/screens/basic_information/basic_information.dart';
import 'package:flutter/material.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../constant/massegas.dart';
import '../../../widgets/custom_surfix_icon.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/form_error.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  // String? conform_password;
  bool remember = false;
  final List<String?> errors = [];
  UserModel userModel = UserModel();

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                print(email);
                _formKey.currentState!.save();
                print(email);
                // if all are valid then go to success screen

                userModel.password = password;
                userModel.email = email;
                print(userModel.password);
                Navigator.pushNamed(context, BasicInformation.routeName,
                    arguments: userModel);
              }
            },
          ),
        ],
      ),
    );
  }

  buildPasswordFormField() {
    return Container(
        child: Material(
            elevation: 15.0,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(15.0),
            child: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                child: TextFormField(
                  obscureText: true,
                  onSaved: (newValue) => password = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPassNullError);
                    } else if (value.length >= 6) {
                      removeError(error: kShortPassError);
                    }
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kPassNullError);
                      return "";
                    } else if (value.length < 6) {
                      addError(error: kShortPassError);
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                  ),
                ))));
  }

  buildEmailFormField() {
    return Container(
        child: Material(
            elevation: 15.0,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(15.0),
            child: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kEmailNullError);
                    } else if (emailValidatorRegExp.hasMatch(value)) {
                      removeError(error: kInvalidEmailError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kEmailNullError);
                      return "";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                      addError(error: kInvalidEmailError);
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  ),
                ))));
  }
}
