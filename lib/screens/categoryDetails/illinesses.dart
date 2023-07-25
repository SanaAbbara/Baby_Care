import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/screens/categoryDetails/component/text_widget.dart';
import 'package:flutter/material.dart';

import 'component/table_data.dart';

class Illinesses extends StatefulWidget {
  final String month;
  const Illinesses({Key? key, required this.month}) : super(key: key);

  @override
  State<Illinesses> createState() => _IllinessesState();
}

class _IllinessesState extends State<Illinesses> {
  bool isactive = false;
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            height: Dimensions.height30,
          ),
          Container(
            width: Dimensions.screenWidth / 2.5,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.height10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.raduis15),
              border: Border.all(width: 1),
              color: AppColors.mainColor.withOpacity(.6),
            ),
            child: Align(
                alignment: Alignment.center,
                child: TextWidget(
                  text: "illinesses repo",
                )),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Center(child: TableDataWidget(month: widget.month)),
          SizedBox(
            height: Dimensions.height10,
          ),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: _illinessesData.length,
          //       itemBuilder: ((context, index) {
          //         return GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               isactive = !isactive;
          //             });
          //           },
          //           child: Container(
          //             child: TextWidget(
          //                 text:
          //                     _illinessesData[index].illinessesName.toString()),
          //           ),
          //         );
          //       })),
        ]),
      ),
    );
  }
}
