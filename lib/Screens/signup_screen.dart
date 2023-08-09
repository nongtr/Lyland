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
  bool? validateEmail;

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/20230808_22.png'),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'images/real-estate-building-logo-design-inspiratiohn-building-logo-design-free-vector copy.png',
              //   height: 250,
              //   width: 250,
              // ),

              //// phone number text field
              SizedBox(
                height: 130,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
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

//////////////////////////////         Email      /////////////////////
              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
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
              ///////////////////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
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
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
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
                height: 10,
              ),
              ////////////////////////// Confirm password ////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2),
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
                  DropdownButton<String>(
                    dropdownColor: Colors.blue,
                    isDense: true,
                    isExpanded: false,
                    iconEnabledColor: Colors.black,
                    focusColor: Colors.black,
                    items: _roles.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
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
                  Text(
                    "نوع الحساب  ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10.0,
              ),

              //////////////////////sign-up box//////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 90),
                child: TextButton(
                  onPressed: SignUp,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.blue,
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
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'لديك حساب بالفعل ؟   ',
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
      ),
    );
  }

  Future SignUp() async {
   bool emailExsits;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
   final CollectionReference usersCollection = firestore.collection('users');
   QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: 'example@example.com').get();
   if (snapshot.docs.isNotEmpty) {
     emailExsits= true;
   } else {
     emailExsits=false;
   }

   if (emailExsits==false && passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => {sendUserInfoToDataBase()});
      final validSnackBar = SnackBar(
          backgroundColor: Colors.green[600],
          content: Text('تم تسجيل الدخول بنجاح'));
      ScaffoldMessenger.of(context)
          .showSnackBar(validSnackBar);
      Navigator.of(context).pushNamed('/');
    }
   else if(emailExsits==false) {
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
  }

  sendUserInfoToDataBase() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference reference =
        FirebaseFirestore.instance.collection('users');
    reference.doc(user!.uid).set({
      'email': _emailController.text,
      'role': role,
      'phoneNumber': _phoneNumberController.text,
      'name': _nameController.text
    });
    Navigator.pushReplacementNamed(context, '/');
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else
      return false;
  }

  Future<bool> checkFieldExists(
      String collectionPath, String fieldName, dynamic fieldValue) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(fieldName, isEqualTo: fieldValue)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  void openSigninScreen() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
