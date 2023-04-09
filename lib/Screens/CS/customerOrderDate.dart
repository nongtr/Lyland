import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class coDate extends StatefulWidget {
  const coDate({Key? key}) : super(key: key);

  @override
  State<coDate> createState() => _coDateState();
}

class _coDateState extends State<coDate> {
  @override
  DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // this is from flutter packages called : table_calendar
            child: TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14)),
          ),
          ////////////////////////////////

          SizedBox(
            height: 20,
          ),
          Container(
              /////////// this is an accept button
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.all(Radius.circular(27))),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  ' تقديم الحجز',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
