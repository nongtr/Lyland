import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/itemDetails.dart';

class Propertyitem extends StatelessWidget {
  const Propertyitem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Image.asset('images/FWSaR5ZWAAAmm3N.jpeg'),
//////////////////////////////////
                      //الزر هو عبارة عن القالب اللي تحت الصورة *اسم و سعر العقار و المنطقة*
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => item_Details()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 35,
                                  blurRadius: 100,
                                  color: Colors.blue,
                                  offset: Offset(0, 10)),
                            ],
                          ),
                          ///////////////////////////////////
                          //هذا اللي فيه قيمة العقار/////
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '\$440',
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              ///////////////////////////////
                              //هذا الصفوف اللي فيهن اسم العقار و اسم المدينة
                              Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'هوتيل مولع',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text('طرابلس'),
                                  ],
                                ),
                              ),
                              //////////////////////////
                            ],
                          ),
                        ),
                      )
                      //////////////////////////////////////////
                    ],
                  ))),
        ],
      ),
    );
  }
}
