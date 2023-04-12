import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/itemDetails.dart';
import 'itemDetails.dart';

class propertyPageBody extends StatefulWidget {
  const propertyPageBody({Key? key}) : super(key: key);

  @override
  State<propertyPageBody> createState() => _propertyPageBodyState();
}

class _propertyPageBodyState extends State<propertyPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 320,
            color: Colors.red.withOpacity(0),
            child: PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (context, postion) {
                  return _buildPageItem(postion);
                })),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(children: [
      Container(
        height: 220,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/1012111.jpg'), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => item_Details()));
          },
          child: Container(
            height: 120,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5.0),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                ]),
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(' لاي لاند', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 0),
                  Row(
                    children: [
                      Wrap(
                          children: List.generate(
                              5,
                              (index) =>
                                  Icon(Icons.star, color: Colors.greenAccent))),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle),
                      Text('شاليه'),
                      SizedBox(width: 5),
                      Icon(Icons.location_city),
                      Text('بنغازي'),
                      SizedBox(width: 5),
                      Icon(Icons.location_pin),
                      Text('الكيش')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
