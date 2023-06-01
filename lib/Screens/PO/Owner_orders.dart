import 'package:flutter/material.dart';
import 'package:lyland/Screens/PO/Owner_ordersList.dart';

class PO_orders extends StatefulWidget {
  const PO_orders({Key? key}) : super(key: key);

  @override
  State<PO_orders> createState() => _PO_ordersState();
}

class _PO_ordersState extends State<PO_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Column(
              children: [
                orders_Per_Proper(),
                orders_Per_Proper(),
                orders_Per_Proper(),
                orders_Per_Proper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class orders_Per_Proper extends StatelessWidget {
  //لما تضغط على عقار معين ينتقل بيك لصفحة طلبات العقار
  const orders_Per_Proper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => orderList()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
          image: DecorationImage(
              image: AssetImage('images/FWSaR5ZWAAAmm3N.jpeg'),
              fit: BoxFit.cover),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        alignment: Alignment.center,
        height: 100,
        width: 410,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Notification(), proTitle()],
        ),
      ),
    );
  }
}

class proTitle extends StatelessWidget {
  //هذا عبارة عن عنوان للعقار التابع للمالك
  const proTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'شاليه فاخر حارق',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(4, 0),
                color: Colors.black,
                blurRadius: 10.0,
              )
            ]),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  //هذا عبارة عن دائرة فيها عدد الطلبات اللي تم تقديمه على عقار معين
  const Notification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(20),
      child: Text(
        '10',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0),
        shape: BoxShape.circle,
        border: new Border.all(color: Colors.white, width: 4),
      ),
    );
  }
}
