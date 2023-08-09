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

  bool valditUser = false;
  String? role;

  Future<void> route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        valditUser = true;
        if (documentSnapshot.get('role') == "زبون") {
          role = 'customerScreen';
        } else {
          role = 'POwnerScreen';
        }
      } else {
        valditUser = false;
      }
    });
  }

  void openSignUpScreen() {
    Navigator.of(context).pushNamed('signUpScreen');
  }

  @override
  void initState() {
    super.initState;
    route();
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
      backgroundColor: Colors.white,
      body: Container(
        height: 800,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/Screensy.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 290,
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "البريد الإلكتروني",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "كلمة السر",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: GestureDetector(
                          onTap: () async {
                            await route();
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              if (valditUser == true) {
                                final validSnackBar = SnackBar(
                                    backgroundColor: Colors.green[600],
                                    content: Text('تم تسجيل الدخول بنجاح'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(validSnackBar);
                                Navigator.pushNamed(context, '$role');
                              } else if (valditUser == false) {
                                final invalidSnackBar = SnackBar(
                                    backgroundColor: Colors.red[600],
                                    content: Text(
                                      'حدث خطأ ما, يرحى المحاولة من جديد',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(invalidSnackBar);
                              }
                            } on FirebaseException catch (e) {
                              final errorFromFirebase = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'الرجاء التأكد من صحة البيانات',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(errorFromFirebase);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 3, bottom: 3),
                            margin: EdgeInsets.only(left: 50, right: 50),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(27)),
                            child: Center(
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: openSignUpScreen,
                            child: Text(
                              'إنشاء حساب جديد ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'أليس لديك حساب ؟ ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}