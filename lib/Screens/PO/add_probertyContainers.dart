import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';

///PRICENUMBER
class addPropertyContainer extends StatelessWidget {
  const addPropertyContainer({
    Key? key,
    required TextEditingController priceControler,
  })  : _priceControler = priceControler,
        super(key: key);

  final TextEditingController _priceControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: TextField(
        controller: _priceControler,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'ادخل سعر الايجار لليلة الواحدة',
          label: Padding(
            padding: EdgeInsets.only(left: 92),
            child: Text(
              'السعر ',
              style: kTitleTextStyle,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

///TITLENAME
class titleName extends StatelessWidget {
  const titleName({
    Key? key,
    required TextEditingController mainLableControler,
  })  : _mainLableControler = mainLableControler,
        super(key: key);

  final TextEditingController _mainLableControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: TextField(
        controller: _mainLableControler,
        decoration: const InputDecoration(
          label: Padding(
            padding: EdgeInsets.only(left: 130),
            child: Text(
              'اسم العقار',
              style: TextStyle(fontSize: 30),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          border: InputBorder.none,
          hintText: 'ادخل العنوان الرئيسي',
        ),
      ),
    );
  }
}
