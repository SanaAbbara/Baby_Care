import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/screens/home_page/home_page_widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../provider/auth/auth.dart';
import 'home_page_widgets/body_home_page/body_home_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //appBar widget
            AppBarWidget(),
            //categories widget
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BodyHomePage(),
            )

            //bottomBar widget
          ],
        ),
      ),
    );
  }
}
