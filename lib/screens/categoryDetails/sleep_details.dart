import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/constant/colors/colors.dart';
import 'package:baby_care/provider/sleep_provider.dart';
import 'package:baby_care/screens/categoryDetails/component/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/gradient_text.dart';
import 'component/audio_palyer_widget.dart';

class SleepDetails extends StatefulWidget {
  String month;
  SleepDetails({Key? key, required this.month}) : super(key: key);

  @override
  State<SleepDetails> createState() => _SleepDetailsState();
}

class _SleepDetailsState extends State<SleepDetails> {
  bool showSleepDuration = false;
  bool isloading = false;
  String? sleepdata;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    Future.wait([
      Provider.of<SleepProvider>(
        context,
        listen: false,
      ).fetchSleep(widget.month),
    ]).then((_) => setState(() {
          isloading = false;
        }));

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    Future.wait([
      Provider.of<SleepProvider>(
        context,
        listen: false,
      ).fetchSleep(widget.month),
    ]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var sleepData = Provider.of<SleepProvider>(context);
    Dimensions().init(context);
    return Scaffold(
      body: Center(
        child: isloading
            ? CircularProgressIndicator()
            : Stack(children: [
                Container(
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("assets/images/sssss.jpg"))),
                ),
                Center(
                  child: Container(
                    width: Dimensions.screenWidth - Dimensions.raduis20,
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: Dimensions.height45,
                          //   width: Dimensions.screenWidth / 4,
                          //   decoration: BoxDecoration(
                          //       color: AppColors.mainColor,
                          //       // border: Border.all(
                          //       //     width: 1, color: AppColors.mainBlackColor),
                          //       borderRadius:
                          //           BorderRadius.circular(Dimensions.raduis15)),
                          //   child: Center(
                          //     child: TextWidget(
                          //       text: "play music",
                          //     ),
                          //   ),
                          // ),
                          AudioPlayerWidget(),

                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showSleepDuration = !showSleepDuration;
                                print(showSleepDuration);
                              });
                            },
                            child: Container(
                              height: Dimensions.height45,
                              width: Dimensions.screenWidth / 4,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  // border: Border.all(
                                  //     width: 1, color: AppColors.mainBlackColor),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.raduis15)),
                              child: Center(
                                child: TextWidget(
                                  text: "sleep houre",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                showSleepDuration
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.raduis30),
                                  topRight:
                                      Radius.circular(Dimensions.raduis30))),
                          height: Dimensions.height45 * 2.5,
                          duration: Duration(seconds: 1),
                          child: Center(
                            child: GradientText(
                              "Sleep Duration For Baby :   " +
                                  sleepData.sleepDuration,
                              style: TextStyle(fontSize: Dimensions.font26),
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade400,
                                Color.fromARGB(255, 1, 24, 59),
                              ]),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ]),
      ),
    );
  }
}
