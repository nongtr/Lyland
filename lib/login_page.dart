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
      backgroundColor: Colors.grey[400],
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
                height: 20,
              ),
              Text(
                'اهلا بك في لاي لاند',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Text('SIGN IN',
                  style: TextStyle(
                      color: Colors.orange,
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
                          hintText: 'Email',
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
                          hintText: 'password',
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
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'sign in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //////////////////////////checking if u have E-m/////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not yet a member ?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'sign up now ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
