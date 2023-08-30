import 'package:flutter/material.dart';

class extendoo extends StatefulWidget {
  final String textD;
  const extendoo({Key? key, required this.textD}) : super(key: key);

  @override
  State<extendoo> createState() => _extendooState();
}

class _extendooState extends State<extendoo> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 140 / 2;

  @override
  void initState() {
    super.initState();
    if (widget.textD.length > textHeight) {
      firstHalf = widget.textD.substring(0, textHeight.toInt());
      secondHalf =
          widget.textD.substring(textHeight.toInt() + 1, widget.textD.length);
    } else {
      firstHalf = widget.textD;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(firstHalf)
            : Column(
          children: [
            Text(hiddenText
                ? (firstHalf + "...")
                : (firstHalf + secondHalf)),
            InkWell(
              onTap: () {
                setState(() {
                  hiddenText = !hiddenText;
                });
              },
              child: Row(
                children: [
                  Text(
                    ' عرض مزيد',
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(hiddenText
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up_outlined)
                ],
              ),
            )
          ],
        ));
  }
}