import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/customerOrderDate.dart';

class item_Details extends StatelessWidget {
  const item_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('images/1012111.jpg'),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  bottomPhotosSilder(),
                  bottomPhotosSilder(),
                  bottomPhotosSilder(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              margin: EdgeInsets.only(
                top: 0,
                left: 250,
              ),
              child: Text(
                'شاليه فاحلر',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ),
            /////////////////////////////////////////////////////
            // هذا القالب اللي فيه المدينةو المنطقو
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3,
              ),
              margin: EdgeInsets.only(left: 200),
              child: Text(
                'بنغازي -الكيش',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange),
              ),
            ),
            //////////////////////////////////////////////

            Description(),
            Row(
              children: [
                ////////////////////////////////////////
                // هذا القالب اللي فيه سعر لليلة
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, top: 60),
                  child: Text(
                    '110d ' + 'night',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                ////////////////////////////////////

                //هذا الزر شور طلب الحجز
                Container(
                    margin: EdgeInsets.only(left: 50, top: 60),
                    width: 190,
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      height: 100,
      width: 180,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          child: Image.asset('images/FWSaR5ZWAAAmm3N.jpeg'),
        ),
      ),
    );
  }
}
///////////////////////////////////////
