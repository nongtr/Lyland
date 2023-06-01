import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';

class orderList extends StatefulWidget {
  const orderList({Key? key}) : super(key: key);

  @override
  State<orderList> createState() => _orderListState();
}

class _orderListState extends State<orderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 75.0),
            child: Text(
              'شاليه فاخر',
              style: kTitleTextStyle,
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40))),
        ),
        backgroundColor: Colors.grey[400],
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 70),
                OrderbyCustomer(),
              ],
            ),
          ),
        ));
  }
}

//هذي عبارة حاوية فيها صف بالـ قوالب(orderstatus
class OrderbyCustomer extends StatelessWidget {
  const OrderbyCustomer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          orderStatus(),
          orderStatus(),
          orderStatus(),
          orderStatus(),
          orderStatus(),
        ],
      ),
    );
  }
}

//هذا عنوان العقار اللي داخلين عليه
// class titleBar extends StatelessWidget {
//   const titleBar({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: AlignmentDirectional.topCenter,
//       width: 450,
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40),
//         color: Colors.white,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 44),
//         child: Text(
//           'شاليه فاخر ',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

//this is the hub Container  which has a order date
class orderStatus extends StatelessWidget {
  const orderStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          Container(
            // هذا القالب الأساسي اللي فيه جواه قوالب فرعية
            margin: EdgeInsets.only(right: 10, left: 20),
            width: 270,
            height: 100,
            child: Column(
              children: [
                Container(
                  // هذي الحاوية عبارة عن قالب فرعي جوا قالب الأساسي شور موعد الحجز
                  height: 55,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Center(
                      child: Text(
                    'موعد الحجز من 24 حتى 25',
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  )),
                ),
                Container(
                    //هذا قالب فرعي واحد ثاني جوا القالب الأساسي وفيه صفين فيهن استدعاء ynButton AKA yes,no button
                    height: 45,
                    width: double.infinity,
                    color: Colors.white,
                    child: SizedBox(
                      height: 47,
                      child: ynButton(),
                    )),
              ],
            ),
          ),

          // هذا استدعاء orderUsername statelessWideget
          orderUsername(),
        ],
      ),
    );
  }
}

// هذي الحاوية اللي فيها اسم المستخدم
class orderUsername extends StatelessWidget {
  const orderUsername({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: new Border.all(color: Colors.black, width: 2),
      ),
      height: 100,
      width: 90,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(20),
      child: Center(
          child: Text(
        'Moh',
        style: TextStyle(fontSize: 18),
      )),
    );
  }
}

// اللي فيه النص امتاع texfield
class ynButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 50),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Center(
                                heightFactor: 1,
                                child: Text('هل انت متأكد ؟',
                                    style: KEditDeleteTextStyle)),
                            actions: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('لا',
                                          style: KEditDeleteTextStyle)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('نعم',
                                          style: KEditDeleteTextStyle))
                                ],
                              ),
                            ],
                          ));
                },
                child: Text(
                  'رفض',
                  style: TextStyle(fontSize: 22),
                )),
            SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'قبول',
                  style: TextStyle(fontSize: 22),
                )),
          ],
        ));
  }
}
