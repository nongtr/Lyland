import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ConfirmpasswordController = TextEditingController();

  Future SignUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      Navigator.of(context).pushNamed('/');
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _ConfirmpasswordController.text.trim()) {
      return true;
    }
    else
      return false;
  }


  void openSigninScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ConfirmpasswordController.dispose();
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

                Text('ادخل البيانات الخاصة بك هنا ',
                    style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20,
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
                ////////////////////////// Confirm password ////////////////////////////////////////////
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _ConfirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'تأكيد كلمة السر',
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
                  child: GestureDetector(
                    onTap: SignUp,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(27)),
                      child: Center(
                        child: Text(
                          'تسجيل حسابك',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
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
                    GestureDetector(
                      onTap: () {
                        openSigninScreen();
                      },
                      child: Text(
                        '  قم بتسجيل الدخول هنا ',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'لديك حساب بالفعل ؟   ',
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