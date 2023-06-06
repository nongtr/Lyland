import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  var _roles = [
    'زبون',
    'مالك عقار',
  ];
  var _currentRoleSelected = 'زبون';
  var role = 'زبون';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            // Image.asset(
            //   'images/real-estate-building-logo-design-inspiratiohn-building-logo-design-free-vector copy.png',
            //   height: 250,
            //   width: 250,
            // ),
            SizedBox(
              height: 40,
            ),

            Text('ادخل البيانات الخاصة بك هنا ',
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            //// phone number text field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'رقم الهاتف',
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),

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
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'اسم المستخدم ',
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ///////////////////////////////////////////
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
                      controller: _confirmPasswordController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "نوع الحساب : ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.orange,
                  isDense: true,
                  isExpanded: false,
                  iconEnabledColor: Colors.white,
                  focusColor: Colors.white,
                  items: _roles.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      _currentRoleSelected = newValueSelected!;
                      role = newValueSelected;
                    });
                  },
                  value: _currentRoleSelected,
                ),
              ],
            ),

            SizedBox(
              height: 10.0,
            ),

            //////////////////////sign-up box//////////////////////////////
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
    );
  }

  Future SignUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => {sendUserInfoToDataBase()});
      Navigator.of(context).pushNamed('/');
    }
  }

  sendUserInfoToDataBase() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference reference =
        FirebaseFirestore.instance.collection('users');
    reference.doc(user!.uid).set({
      'email': _emailController.text,
      'role': role,
      'phoneNumber': _phoneNumberController.text
    });
    Navigator.pushReplacementNamed(context, 'loginScreen');
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else
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
    _confirmPasswordController.dispose();
  }
}
