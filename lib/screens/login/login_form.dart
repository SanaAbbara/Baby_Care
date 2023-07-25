import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/model/user_model.dart';
import 'package:baby_care/screens/home_page/bottom_navbar/bottom_navbar.dart';
import 'package:baby_care/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../constant/massegas.dart';
import '../../../widgets/custom_surfix_icon.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/form_error.dart';
import '../../provider/auth/auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _isLoading = false;
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

  Map<String, dynamic> _authdata = {};

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        _authdata['email'] = email;
        _authdata['password'] = password;

        print(_authdata['email']);
        await Provider.of<Auth>(context, listen: false)
            .login(email!, password!)
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())));

        print("login success " + _authdata['email']);

        //Navigator.of(context).pushReplacementNamed(PropertyHomePage.routeName);
      }
      // on HttpException catch (error) {
      //   var errorMessage = error.toString();
      //   _showErrorDialog(errorMessage);
      // }
      catch (error) {}
    }
    setState(() {
      _isLoading = false;
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
          _isLoading == false
              ? DefaultButton(text: "Continue", press: _submit)
              : CircularProgressIndicator(),

          SizedBox(height: getProportionateScreenHeight(50)),
          Center(
            child: Text(
              "Don't Have Account ?Create Account",
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),

          DefaultButton(
              text: "Sign Up",
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              }),
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
