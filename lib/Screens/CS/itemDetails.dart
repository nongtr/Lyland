import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/customerOrderDate.dart';
import 'package:lyland/constants.dart';

class item_Details extends StatelessWidget {
  const item_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(08),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 430,
                width: 400,
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        height: 430,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'images/1012111.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            width: 360,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 20, bottom: 0),
                              child: Row(
                                children: [
                                  Text(
                                    ' لليلة /',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    ' د124',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.orange),
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'شاليه فاخر',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ' بنغازي - الكيش',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                          Icon(
                                            Icons.home,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 280),
                  child: Text(
                    'نظرة عامة',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    bottomPhotosSilder(),
                    bottomPhotosSilder(),
                    bottomPhotosSilder(),
                    bottomPhotosSilder(),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 10,
              //   ),
              //   margin: EdgeInsets.only(
              //     top: 0,
              //     left: 250,
              //   ),
              //   child: Text(
              //     'شاليه فاحلر',
              //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              //   ),
              // ),
              /////////////////////////////////////////////////////
              // هذا القالب اللي فيه المدينةو المنطقو
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 3,
              //   ),
              //   margin: EdgeInsets.only(left: 200),
              //   child: Text(
              //     'بنغازي -الكيش',
              //     style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w700,
              //         color: Colors.orange),
              //   ),
              // ),
              //////////////////////////////////////////////
              SizedBox(height: 15),
              Container(
                  margin: EdgeInsets.only(left: 260),
                  child: Text(
                    'وصف العقار',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Description(),
              Row(
                children: [
                  ////////////////////////////////////////
                  // هذا القالب اللي فيه سعر لليلة
                  ///////////////////////////////
                  //هذا الزر شور طلب الحجز
                  Container(
                      margin: EdgeInsets.only(left: 50, top: 30),
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.all(Radius.circular(27))),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(

                              // you can say it's popup page navigator or mini page
                              isScrollControlled: true,
                              //هذي حتخلي الصفحة تكبر على حسب العناصر اللي فيها

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40))),
                              context: context,
                              //we calling cusotomerOrderDate class which is called coDate
                              builder: (cotext) => coDate());
                        },
                        child: Text(
                          'طلب الحجز',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
// هذا عبارة عن ويدجت مستقلة تحط في وصف العقار
class Description extends StatelessWidget {
  const Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(
          top: 15,
          left: 0,
        ),
        child: Column(
          children: [
            Text(
              'شاليه يمتاز بالراحة و سهولة الوصول اليه و نظراً لأن مفيش كلام في بالي حالياً و حنذكر مواضيع عشوائية عشان بس نختبر الجو ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
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
