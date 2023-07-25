import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:flutter/material.dart';

import 'splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Engane the whole family",
      "image": "assets/images/img1.jpg",
      'discription':
          "We're here to inform and empower the whole family as your baby develops"
    },
    {
      "text": "medicine &teach belong together",
      "image": "assets/images/img2.jpg",
      'discription':
          "we believe that the best healthcare is evidence-based sinence,and are using Al to move forward"
    },
    {
      "text": "keep security in mind",
      "image": "assets/images/img3.jpg",
      'discription':
          "we're doctors and parents too,so we're committed to keeping u data private "
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: Dimensions.screenHeight - Dimensions.height30 * 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                    discription: splashData[index]['discription'],
                  ),
                ),
              ),
              Container(
                height: Dimensions.height45 * 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: currentPage == index
          ? Dimensions.height20 * 2.5
          : Dimensions.height20,
      width: currentPage == index
          ? Dimensions.height20 * 2.5
          : Dimensions.height20,
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(Dimensions.raduis20 * 4),
      ),
      child: currentPage == index
          ? Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_forward,
              ),
            )
          : Container(),
    );
  }
}
