import 'package:baby_care/provider/food_provider.dart';
import 'package:baby_care/provider/illinesses_provider.dart';
import 'package:baby_care/provider/sleep_provider.dart';
import 'package:baby_care/provider/tips_provider.dart';
import 'package:baby_care/provider/vaccine_provider.dart';
import 'package:baby_care/screens/basic_information/basic_information.dart';
import 'package:baby_care/screens/basic_information/component/basic_form_step2.dart';
import 'package:baby_care/screens/home_page/bottom_navbar/bottom_navbar.dart';
import 'package:baby_care/screens/profile/my_profile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth/auth.dart';
import 'screens/login/login_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: VaccineProvider()),
          ChangeNotifierProvider.value(value: FoodProvider()),
          ChangeNotifierProvider.value(value: TipsProvider()),
          ChangeNotifierProvider.value(value: SleepProvider()),
          ChangeNotifierProvider.value(value: IllinessesProvider()),
          ChangeNotifierProvider.value(value: Auth()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.userid == ""
                ? HomePage()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? HomePage()
                            : auth.firstsign == 0
                                ? SplashScreen()
                                : LoginScreen(),
                  ),
            routes: {
              BasicInformation.routeName: (context) => BasicInformation(),
              BasicFormStep2.routeName: (context) => BasicFormStep2(),
            },
          ),
        ));
  }
}
