import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/provider/tips_provider.dart';
import 'package:baby_care/screens/categoryDetails/component/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth/auth.dart';

class TipsDetails extends StatefulWidget {
  String month;
  TipsDetails({Key? key, required this.month}) : super(key: key);

  @override
  State<TipsDetails> createState() => _TipsDetailsState();
}

class _TipsDetailsState extends State<TipsDetails> {
  bool isloading = false;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    Future.wait([
      // Provider.of<Auth>(context, listen: false).tryAutoLogin().then(
      //       (value) =>

      Provider.of<TipsProvider>(
        context,
        listen: false,
      ).fetchTips(widget.month),
      //)
    ]).then((_) => setState(() {
          isloading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tipsDatas = Provider.of<TipsProvider>(context, listen: false);
    Dimensions().init(context);
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.height45,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: TextWidget(
                      text: "Tips Page ",
                      fontcolor: AppColors.titleColor,
                      fontsize: Dimensions.font26,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      child: ListView.builder(
                          itemCount: tipsDatas.tipsData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.width10),
                              child: Row(
                                children: [
                                  Container(
                                    height: Dimensions.height30 * 2,
                                    width: Dimensions.height30 * 2,
                                    decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? AppColors.mainColor
                                            : AppColors.secondColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.screenWidth / 2)),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: AppColors.textColor)),
                                    ),
                                    child: ListTile(
                                      title: TextWidget(
                                        text: tipsDatas.tipsData[index].title,
                                        fontsize: Dimensions.font20,
                                      ),
                                      subtitle: TextWidget(
                                        text:
                                            tipsDatas.tipsData[index].subTitle,
                                        fontsize: Dimensions.font15,
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
