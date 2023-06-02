import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Customer_screenBar.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future Signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text);
    route();
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "زبون") {
          Navigator.pushNamed(context, 'customerScreen');
        } else {
          Navigator.pushNamed(context, 'POwnerScreen');
        }
      }
    });
  }

  void openSignUpScreen() {
    Navigator.of(context).pushNamed('signUpScreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: <Widget>[
//////////////////////////// title /////////////////////////
          SingleChildScrollView(
            child: Column(
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
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
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
                          controller: _passwordController,
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
                Container(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: (){
                      Signin;
                      if(_emailController==null || _passwordController==null) {
                        final invalidSnackBar = SnackBar(
                          showCloseIcon: true,
                            backgroundColor: Colors.red,
                            content: Text('حدث خطأ ما, يرحى المحاولة من جديد'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            invalidSnackBar);
                      }
                      else{
                        final validSnackBar = SnackBar(
                          showCloseIcon: true,
                            backgroundColor: Colors.teal,
                            content: Text('تم تسجيل الدخول بنجاح'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            validSnackBar);
                      }


                    },
                        child: Text('تسجيل دخول'),
                    ),
                  ),
                ),
               /* Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: Signin,
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
                ),*/

                SizedBox(
                  height: 40,
                ),

                //////////////////////////checking if u have E-m/////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        openSignUpScreen();
                      },
                      child: Text(
                        '  إنشاء حساب جديد  ',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
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
          ),

          // Container(
          //     decoration: BoxDecoration(color: Colors.cyanAccent),
          //     child: TextField()),
        ],
      ),
    );
  }
}
