import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: <Widget>[
          // Image.asset(
          //   // 'images/Untitled-1.jpg',
          //   // width: double.infinity,
          // ),

//////////////////////////// title /////////////////////////
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'images/real-estate-building-logo-design-inspiratiohn-building-logo-design-free-vector copy.png',
                height: 250,
                width: 250,
              ),

              Text('اهلا بك ',
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),

//////////////////////////////         Email      /////////////////////
              //

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'البريد الإلكتروني',
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),

              ////////////////////////// password ////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'كلمة السر',
                        ),
                      ),
                    )),
              ),

              SizedBox(
                height: 20,
              ),

              //////////////////////sign-in box//////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(27)),
                  child: Center(
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),

              //////////////////////////checking if u have E-m/////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '  إنشاء حساب جديد  ',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'أليس لديك حساب ؟   ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),

          // Container(
          //     decoration: BoxDecoration(color: Colors.cyanAccent),
          //     child: TextField()),
        ],
      ),
    );
  }
}
