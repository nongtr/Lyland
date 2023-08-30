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

  bool ? valditUser ;
  String? role;

  Future<void> route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = await FirebaseFirestore.instance
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
    return kk;
  }

  void openSignUpScreen() {
    Navigator.of(context).pushNamed('signUpScreen');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/121422c.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                children: [
                  Text(
                    'مرحبا بك',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
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
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 65),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(invalidSnackBar);
                          }
                        } on FirebaseException catch (e) {
                          final errorFromFirebase = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'الرجاء التأكد من صحة البيانات',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                    height: 30,
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
          ],
        ),
      ),
    );
  }
}