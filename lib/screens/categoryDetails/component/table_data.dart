import 'package:baby_care/constant/Dimensions/domensions.dart';
import 'package:baby_care/screens/categoryDetails/illinesses_details/illinesses_details.dart';
import 'package:flutter/material.dart';

class TableDataWidget extends StatefulWidget {
  final String month;
  const TableDataWidget({Key? key, required this.month}) : super(key: key);

  @override
  State<TableDataWidget> createState() => _TableDataWidgetState();
}

class _TableDataWidgetState extends State<TableDataWidget> {
  List chars = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.screenHeight / 1.4,
        width: Dimensions.screenWidth / 1.5,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.5,
            crossAxisCount: 4,
          ),
          children: List.generate(
              chars.length,
              (index) => Center(
                    child: GestureDetector(
                      onTap: () {
                        print(chars[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IllinessesDetails(
                                      charName: chars[index],
                                      month: widget.month,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.circular(Dimensions.raduis20 / 4)),
                        child: Center(child: Text(chars[index])),
                      ),
                    ),
                  )),
        ));
  }
}
