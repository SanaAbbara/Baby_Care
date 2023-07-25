import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/screens/categoryDetails/component/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors/colors.dart';
import '../../../provider/auth/auth.dart';
import '../../../provider/illinesses_provider.dart';

// ignore: must_be_immutable
class IllinessesDetails extends StatefulWidget {
  final String month;
  String charName;
  IllinessesDetails({Key? key, required this.charName, required this.month})
      : super(key: key);

  @override
  State<IllinessesDetails> createState() => _IllinessesDetailsState();
}

class _IllinessesDetailsState extends State<IllinessesDetails> {
  bool taped = false;
  bool isloading = false;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    Future.wait([
      Provider.of<IllinessesProvider>(
        context,
        listen: false,
      ).fetchIllinesses(widget.charName),
    ]).then((_) => setState(() {
          isloading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _illinessesData = Provider.of<IllinessesProvider>(context);

    Dimensions().init(context);
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.height30,
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10,
                          vertical: Dimensions.height10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.raduis15),
                        border: Border.all(width: 1),
                        color: AppColors.mainColor.withOpacity(.6),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            text: "Medicine Repo",
                            fontsize: Dimensions.font26,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10,
                          vertical: Dimensions.height10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.raduis15),
                        border: Border.all(width: 1),
                        color: AppColors.mainColor.withOpacity(.6),
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            text: widget.charName,
                            fontsize: Dimensions.font26,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            Dimensions.raduis15,
                          ),
                          topRight: Radius.circular(
                            Dimensions.raduis15,
                          )),
                      border: Border.all(width: 1),
                      color: AppColors.mainColor.withOpacity(.0),
                    ),
                    //  width: Dimensions.screenWidth / 1.2,
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    child: Column(
                      children: List.generate(
                          _illinessesData.illinesses.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: index == 0
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(
                                              Dimensions.raduis15,
                                            ),
                                            topRight: Radius.circular(
                                              Dimensions.raduis15,
                                            ))
                                        : BorderRadius.zero,
                                    color: index.isEven
                                        ? AppColors.textColor.withOpacity(.3)
                                        : AppColors.signColor.withOpacity(.5)),
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height15),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(
                                            text: _illinessesData
                                                .illinesses[index]
                                                .illinessesName,
                                            fontsize: Dimensions.font26,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                taped = !taped;
                                              });
                                              _illinessesData.illinesses[index]
                                                  .taped = taped;
                                            },
                                            child: _illinessesData
                                                        .illinesses[index]
                                                        .taped ==
                                                    false
                                                ? Icon(
                                                    Icons.arrow_upward,
                                                    size: Dimensions.iconsize24,
                                                  )
                                                : Icon(
                                                    Icons.arrow_downward,
                                                    size: Dimensions.iconsize24,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: TextWidget(
                                          text: "medicine for this illinesses",
                                          fontsize: Dimensions.font15,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width20,
                                            vertical: Dimensions.height10 / 2),
                                      ),
                                    ),
                                    _illinessesData.illinesses[index].taped ==
                                            true
                                        ? SingleChildScrollView(
                                            child: Container(
                                              child: Column(
                                                  children: List.generate(
                                                _illinessesData
                                                    .illinesses[index]
                                                    .medicineName!
                                                    .length,
                                                (indexitem) => Container(
                                                  width: Dimensions.screenWidth,
                                                  // decoration: BoxDecoration(
                                                  //   color: indexitem.isEven
                                                  //       ? AppColors.mainColor
                                                  //           .withOpacity(.2)
                                                  //       : AppColors.mainBlackColor
                                                  //           .withOpacity(.2),
                                                  // ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Dimensions.height10),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: TextWidget(
                                                            fontsize: Dimensions
                                                                .font15,
                                                            text: _illinessesData
                                                                    .illinesses[
                                                                        index]
                                                                    .medicineName![
                                                                indexitem]),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      Dimensions
                                                                          .width30),
                                                          child: Divider(
                                                            color: Colors.grey,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              )),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height45,
                  )
                ],
              ),
            ),
    );
  }
}
