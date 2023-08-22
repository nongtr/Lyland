import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/20230808_22.png'),
                  fit: BoxFit.fill)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'اسم المستخدم',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يرجى إدخال اسم المستخدم';
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',

                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يرجى ادخال رقم الهاتف';
                            }
                            return null;
                          },
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'بريد الكتروني',

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى ادخال بريد الكتروني';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'[^a-zA-Z0-9@._-]'),
                            replacementString: '',
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'كلمة السر',

                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يرجى ادخال كلمة السر';
                            }
                            return null;
                          },
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
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة السر',

                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يرجى تأكيد كلمة السر';
                            }
                            return null;
                          },
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
                    onPressed:  () {
                      if (_formKey.currentState!.validate()) {
                        SignUp();
                      } else {
                        final invalidSnackBar = SnackBar(
                          backgroundColor: Colors.red[600],
                          content: Text(
                            'يرجى إدخال جميع الحقول المطلوبة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(invalidSnackBar);
                      }
                    },
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
      ),
    );
  }

  Future SignUp() async {
   bool emailExsits;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
   final CollectionReference usersCollection = firestore.collection('users');
   QuerySnapshot snapshot = await usersCollection
       .where('email', isEqualTo: _emailController.text.trim())
       .get();
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
   else if(emailExsits==true) {
     final invalidSnackBar = SnackBar(
         backgroundColor: Colors.red[600],
         content: Text(
           'البريد الالكتروني مسجل مسبقا',
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
