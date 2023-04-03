import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  // هذينا متغيرات هدفهن ان يتأكد من صحة البيانات عن طريق حفظ هذينا القيم بيش نستعملوها بعدين
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

// هذي الميثود اللي من خلالها تستقبل المدخلات و منها تشوف صحة البيانات
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

// هذي هدفها انها تعطل المتغيرات اللي فوف في حال عدم إستخدامها
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
      body: SingleChildScrollView(
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: signIn,
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
      ),
    );
  }
}
