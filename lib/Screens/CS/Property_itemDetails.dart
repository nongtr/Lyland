import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Customer_OrderDate.dart';
import 'package:lyland/constants.dart';
import 'package:lyland/Widget/extandable_discription.dart';

class item_Details extends StatelessWidget {
  const item_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 320,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/1012111.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 24,
            right: 360,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 45,
              color: Colors.white,
              shadows: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 0), blurRadius: 7)
              ],
            ),
          ),
          Positioned(
              top: 250,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 450,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          appColumn(
                              title: 'هاي لاند ',
                              type: 'شاليه',
                              city: 'بنغازي',
                              area: 'الكيش'),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'الصور',
                            style: TextStyle(fontSize: 25),
                          ),
                          Container(
                            height: 90,
                            width: double.maxFinite,
                            color: Colors.red.withOpacity(0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  bottomPhotosSilder(),
                                  bottomPhotosSilder(),
                                  bottomPhotosSilder(),
                                  bottomPhotosSilder()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('الوصف', style: TextStyle(fontSize: 25)),
                          Expanded(
                            child: SingleChildScrollView(
                              child: extendoo(
                                  textD:
                                      'يا اهلا وسهلا فيكم في تطبيق لاي لاند للحجز المبدئي التطبيق اللي فيه كل العقارات اللي في بالك من شاليهات و استراحات و هوتيلات و كل ما في قلبك قاعد يا سي غير سجل فيه و مش حتندم  '),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Container(
              width: 180,
              height: 40,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 14.0,
                    left: 34,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'لليلة',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'د',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        '124',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    context: context,
                    builder: (context) => coDate());
              },
              child: Container(
                height: 100,
                width: 150,
                padding: EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'طلب الحجز',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class appColumn extends StatelessWidget {
  final String title;
  final String type;
  final String city;
  final String area;
  const appColumn(
      {Key? key,
      required this.title,
      required this.type,
      required this.city,
      required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: TextStyle(fontSize: 20)),
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
                children: List.generate(
                    5, (index) => Icon(Icons.star, color: Colors.greenAccent))),
            SizedBox(
              width: 10,
            ),
            Text('4.5'),
            SizedBox(
              width: 10,
            ),
            Text('تقييم')
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.circle),
            Text(type),
            SizedBox(width: 5),
            Icon(Icons.location_city),
            Text(city),
            SizedBox(width: 5),
            Icon(Icons.location_pin),
            Text(area)
          ],
        )
      ],
    );
  }
}

////////////////////////////////////////////////////////////////
// هذا عبارة عن ويدجت مستقلة تحط في وصف العقار

////////////////////////////////////////////////////
// هذا عبارة عن ويدجيت مستقلة اللي منها درت و حطيت الصور الجانبية على شكل قالب

class bottomPhotosSilder extends StatelessWidget {
  const bottomPhotosSilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      height: 80,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Image.asset('images/FWSaR5ZWAAAmm3N.jpeg'),
      ),
    );
  }
}
// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Row(
//     children: [
//       bottomPhotosSilder(),
//       bottomPhotosSilder(),
//       bottomPhotosSilder(),
//       bottomPhotosSilder(),
//     ],
//   ),
// ),
