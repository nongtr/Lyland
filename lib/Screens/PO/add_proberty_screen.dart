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
        appBar: AppBar(
          backgroundColor: Colors.white38,
          leading: IconButton(
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.only(left: 330.0),
                child: Icon(
                  Icons.home_filled,
                  size: 34,
                ),
              )),
          title: Padding(
            padding: const EdgeInsets.only(left: 58.0, top: 5),
            child: Text(
              'اضافة عقار جديد',
              style: kTitleTextStyle,
            ),
          ),
        ),
        backgroundColor: Colors.grey[500],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 20, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 90,
                ),
                // main lable text field
                titleName(mainLableControler: _mainLableControler),
                SizedBox(
                  height: 15.0,
                ),

                Text(
                  ':نوع العقار',
                  style: kTitleTextStyle,
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

                Text(
                  ':المدينة',
                  style: kTitleTextStyle,
                ),
                Container(
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
                      padding: const EdgeInsets.only(left: 103),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCity,
                          items: _cityList
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
                Text(
                  ':المنطقة',
                  style: kTitleTextStyle,
                ),
                Container(
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
                      padding: const EdgeInsets.only(left: 103),
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
                  height: 25.0,
                ),
                priceNumber(priceControler: _priceControler),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'يسمح لك بإضافة 6 صور ',
                      style: TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'صور للإعلان',
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
                add_Pictures(),
                SizedBox(
                  height: 20,
                )
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

class add_Pictures extends StatelessWidget {
  const add_Pictures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0),
        border: Border.all(width: 4, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 380,
      height: 220,
      child: Row(
        children: [
          Column(
            children: [firstRowPhotos(), secondRowPhotos()],
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(0),
                  border: Border.all(width: 4, color: Colors.white)),
              width: 90,
              height: 80,
              child: Icon(
                Icons.photo_camera_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class secondRowPhotos extends StatelessWidget {
  const secondRowPhotos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ImageContainer(),
          ImageContainer(),
          ImageContainer(),
        ],
      ),
    );
  }
}

class firstRowPhotos extends StatelessWidget {
  const firstRowPhotos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ImageContainer(),
          ImageContainer(),
          ImageContainer(),
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 2, top: 20),
      width: 80,
      height: 80,
      child: Image(
        image: AssetImage(
          'images/1012111.jpg',
        ),
        fit: BoxFit.fill,
      ),
    );
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
      width: 180,
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