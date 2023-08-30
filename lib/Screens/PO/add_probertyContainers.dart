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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Container(
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _priceControler,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '100',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Text(
              ':السعر',
              style: kTitleTextStyle,
            ),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _mainLableControler,
            textAlign: TextAlign.right, // Align text to the right

            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "اسم العقار ",
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}
