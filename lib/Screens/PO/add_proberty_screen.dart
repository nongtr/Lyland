import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';

class addProberty extends StatefulWidget {
  const addProberty({Key? key}) : super(key: key);

  @override
  State<addProberty> createState() => _addProbertyState();
}

class _addProbertyState extends State<addProberty> {
  List<String> _cityList = ['بنغازي', 'طرابلس'];
  String? _selectedCity = 'بنغازي';
  List<String> _areaList = ['الكيش', 'الحدائق'];
  String? _selectedArea = 'الكيش';
  final _mainLableControler = TextEditingController();
  final _priceControler = TextEditingController();
  int _probertyType = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[500],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 90,
                ),
                // main lable text field
                titleName(mainLableControler: _mainLableControler),
                SizedBox(
                  height: 15.0,
                ),

                // row for radio buttons
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'شقة',
                      style: kTitleTextStyle,
                    ),
                    Radio(
                        value: 2,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'استراحة',
                      style: kTitleTextStyle,
                    ),
                    Radio(
                        value: 3,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'شاليه',
                      style: kTitleTextStyle,
                    )
                  ],
                ),

                //drop down menu for the city
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: Text(
                    ':المدينة',
                    style: kTitleTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 196, bottom: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('اسم المدينة'),
                          value: _selectedCity,
                          items: _cityList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: kTitleTextStyle,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _selectedCity = item),
                        ),
                      ),
                    ),
                  ),
                ),

                // drop down menu for the area
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: Text(
                    ':المنطقة',
                    style: kTitleTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 193),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedArea,
                          items: _areaList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: kTitleTextStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _selectedArea = item),
                        ),
                      ),
                    ),
                  ),
                ),

                // text field for the price
                SizedBox(
                  height: 15.0,
                ),
                priceNumber(priceControler: _priceControler),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          child: BottomAppBar(
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                    },
                    child: Text(
                      'Save',
                      style: kTitleTextStyle,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                    },
                    child: Text(
                      'cancel',
                      style: kTitleTextStyle,
                    )),
              ],
            ),
          ),
        ));
  }
}

class priceNumber extends StatelessWidget {
  const priceNumber({
    Key? key,
    required TextEditingController priceControler,
  })  : _priceControler = priceControler,
        super(key: key);

  final TextEditingController _priceControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100),
      child: TextField(
        controller: _priceControler,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'ادخل سعر الايجار لليلة الواحدة',
          label: Text(
            'السعر ',
            style: kTitleTextStyle,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
      ),
    );
  }
}

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
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: _mainLableControler,
        decoration: const InputDecoration(
          label: Text(
            'اسم العقار',
            style: TextStyle(fontSize: 30),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          border: InputBorder.none,
          hintText: 'ادخل العنوان الرئيسي',
        ),
      ),
    );
  }
}
