import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/model/foodModel.dart';
import 'package:baby_care/provider/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/colors/colors.dart';
import 'component/text_widget.dart';

class FoodDetails extends StatefulWidget {
  final String month;
  FoodDetails({Key? key, required this.month}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  bool isloading = false;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    Future.wait([
      Provider.of<FoodProvider>(
        context,
        listen: false,
      ).fetchFood(widget.month),
    ]).then((_) => setState(() {
          isloading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var foodData = Provider.of<FoodProvider>(context).foodData;
    Dimensions().init(context);
    return Scaffold(
        body: Center(
            child: isloading
                ? CircularProgressIndicator()
                : Stack(children: [
                    Positioned(
                      top: -20,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.screenHeight / 4,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.raduis30 * 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/ballon.jpg"))),
                      ),
                    ),
                    Column(children: [
                      SizedBox(
                        height: Dimensions.height45 * 2.2,
                      ),
                      Center(
                        child: Text(
                          "Food Details",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Expanded(child: FoodData(foodData: foodData)),
                    ]),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.screenHeight / 4,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.raduis30 * 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/ballon.jpg"))),
                      ),
                    ),
                  ])));
  }
}

class FoodData extends StatelessWidget {
  const FoodData({
    Key? key,
    required this.foodData,
  }) : super(key: key);

  final List<FoodModel> foodData;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: Dimensions.screenHeight / 4,
        // margin: EdgeInsets.symmetric(
        //     horizontal: Dimensions.width10, vertical: Dimensions.height10),
        // padding: EdgeInsets.symmetric(
        //     horizontal: Dimensions.width10, vertical: Dimensions.height10),
        // decoration: BoxDecoration(
        //     color: AppColors.mainColor,
        //     border: Border.all(width: 1, color: AppColors.mainColor),
        //     borderRadius: BorderRadius.circular(Dimensions.raduis15 / 2)),
        child: Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(columns: [
            DataColumn(label: Text("type Food")),
            DataColumn(label: Text("recommend ")),
          ], rows: [
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Breast milk",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                TextWidget(
                  text: foodData[0].nMilk![0],
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              )
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Formula milk",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                TextWidget(
                  text: foodData[0].fmilk![0],
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              )
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Fruits",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                Center(
                  child: Container(
                    // height: Dimensions.height45,
                    width: Dimensions.screenWidth / 1.8,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodData[0].fruits!.length,
                        itemBuilder: ((context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              foodData[0].fruits![index] + "  ",
                              style: TextStyle(
                                  color: AppColors.titleColor,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        })),
                  ),
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Vegetables",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                Center(
                  child: Container(
                    // height: Dimensions.height45,
                    width: Dimensions.screenWidth / 1.8,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodData[0].vegetables!.length,
                        itemBuilder: ((context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              foodData[0].vegetables![index] + "  ",
                              style: TextStyle(
                                  color: AppColors.titleColor,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        })),
                  ),
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Cyrbohedats",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                Center(
                  child: Container(
                    // height: Dimensions.height45,
                    width: Dimensions.screenWidth / 1.8,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodData[0].cyrbohedats!.length,
                        itemBuilder: ((context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              foodData[0].cyrbohedats![index] + "  ",
                              style: TextStyle(
                                  color: AppColors.titleColor,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        })),
                  ),
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Cremy",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                Center(
                  child: Container(
                    // height: Dimensions.height45,
                    width: Dimensions.screenWidth / 1.8,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foodData[0].cremy!.length,
                        itemBuilder: ((context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              foodData[0].cremy![index] + "  ",
                              style: TextStyle(
                                  color: AppColors.titleColor,
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        })),
                  ),
                ),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                TextWidget(
                  text: "Water",
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              ),
              DataCell(
                TextWidget(
                  text: foodData[0].water![0],
                  fontcolor: AppColors.titleColor,
                  fontsize: Dimensions.font20,
                ),
              )
            ]),
          ]),
        ),
      ],
    ));
  }
}
