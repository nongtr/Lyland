import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class coDate extends StatefulWidget {
  final String propertyName;
  final String owenerID;
  final String pNumber;
  coDate(
      {required this.propertyName,
      required this.owenerID,
      required this.pNumber});

  @override
  _coDateState createState() => _coDateState();
}

class _coDateState extends State<coDate> {
  DateTime? _firstDay;
  DateTime? _lastDay;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  final dayMonthFormat = DateFormat('d MMM yyy');
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  ////////////////////////////////
  void submitSelectedRange() async {
    if (_firstDay != null && _lastDay != null) {
      final ordersRef = FirebaseFirestore.instance.collection('orders');
      //////////////////////
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userData = await userDocRef.get();
// Access the document fields
      final String username = userData.get('name');

      await ordersRef.add({
        'firstDay': dayMonthFormat.format(_firstDay!),
        'lastDay': dayMonthFormat.format(_lastDay!),
        'propertyName': widget.propertyName,
        'useID': userId,
        'userName': username,
        'ownerID': widget.owenerID,
        'cState': 'قيد المراجعة',
        'status': 'يرجى التواصل مع المالك على الرقم :   '
            '${widget.pNumber}'
      });
      setState(() {
        _firstDay = null;
        _lastDay = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2022),
            lastDay: DateTime(2025),
            selectedDayPredicate: (day) {
              return _firstDay != null && _lastDay != null
                  ? day.isAfter(_firstDay!) && day.isBefore(_lastDay!)
                  : _firstDay == day || _lastDay == day;
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (_firstDay == null) {
                setState(() {
                  _firstDay = selectedDay;
                });
              } else if (_lastDay == null) {
                if (selectedDay.isAfter(_firstDay!)) {
                  setState(() {
                    _lastDay = selectedDay;
                  });
                } else {
                  setState(() {
                    _firstDay = selectedDay;
                  });
                }
              } else {
                setState(() {
                  _firstDay = selectedDay;
                  _lastDay = null;
                });
              }
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Selected range:'),
              SizedBox(height: 10),
              Text(
                '${_firstDay != null ? dayMonthFormat.format(_firstDay!) : 'N/A'} - ${_lastDay != null ? dayMonthFormat.format(_lastDay!) : 'N/A'}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _firstDay == null || _lastDay == null
                ? null
                : () {
                    submitSelectedRange();

                    Navigator.of(context)
                        .pushReplacementNamed('customerScreen');
                  },
            child: Text(
              'تقديم الطلب',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
