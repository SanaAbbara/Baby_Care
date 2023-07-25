import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/provider/auth/auth.dart';
import 'package:baby_care/provider/vaccine_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VaccinesDetails extends StatefulWidget {
  final String month;
  const VaccinesDetails({Key? key, required this.month}) : super(key: key);

  @override
  State<VaccinesDetails> createState() => _VaccinesDetailsState();
}

class _VaccinesDetailsState extends State<VaccinesDetails> {
  bool isloading = false;
  String? istake;

  List<String> takes = ["True", "False"];
  String? useriddata;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    print(widget.month);
    Future.wait([
      Provider.of<Auth>(context, listen: false).getuserid().then((value) {
        useriddata = value;
      }),
      Provider.of<VaccineProvider>(
        context,
        listen: false,
      ).fetchVaccine(widget.month)
    ]).then((_) => setState(() {
          isloading = false;
        }));
    print("the month data is ");

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();

  //   Future.wait([
  //     Provider.of<VaccineProvider>(
  //       context,
  //       listen: false,
  //     ).fetchVaccine("1")
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    var vaccineData = Provider.of<VaccineProvider>(context);
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
                    height: Dimensions.screenHeight,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.raduis30 * 2),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/ballon.jpg"))),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height45 * 2,
                      ),
                      Center(
                        child: Text(
                          "Vaccines",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: vaccineData.vaccines.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: Dimensions.screenHeight / 4,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                  vertical: Dimensions.height10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                  vertical: Dimensions.height10),
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? AppColors.mainColor
                                      : AppColors.secondColor,
                                  border: Border.all(
                                      width: 1, color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.raduis15 / 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            "vaccineName",
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            vaccineData
                                                .vaccines[index].vaccineName!,
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            "doseNum",
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            vaccineData.vaccines[index].doseNum!
                                                .toString(),
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            "deadLine",
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            vaccineData
                                                .vaccines[index].deadLine!,
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: Dimensions.width30 * 4.5,
                                          child: Text(
                                            "taken",
                                            style: TextStyle(
                                                color: AppColors.titleColor,
                                                fontSize: Dimensions.font20,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Consumer<VaccineProvider>(
                                          builder: (context, vaccin, child) {
                                        return Container(
                                            width: Dimensions.width30 * 4.5,
                                            child: vaccineData.vaccines[index]
                                                        .taken ==
                                                    false
                                                ? DropdownButtonFormField(
                                                    hint: Text(vaccineData
                                                        .vaccines[index].taken!
                                                        .toString()),
                                                    items:
                                                        takes.map((String val) {
                                                      return DropdownMenuItem(
                                                        value: val,
                                                        child: Text(
                                                          val,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      if (value == "True") {
                                                        setState(() {
                                                          vaccin.checkvaccine(
                                                              useriddata!,
                                                              vaccineData
                                                                  .vaccines[
                                                                      index]
                                                                  .vaccinId
                                                                  .toString());
                                                          vaccineData
                                                              .vaccines[index]
                                                              .taken = true;
                                                        });
                                                      }
                                                    })
                                                : Text(
                                                    vaccineData
                                                        .vaccines[index].taken!
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .titleColor,
                                                        fontSize:
                                                            Dimensions.font20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ));
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
