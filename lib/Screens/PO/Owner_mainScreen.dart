import 'package:flutter/material.dart';
import 'add_proberty_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';

class PO_mainScreen extends StatelessWidget {
  const PO_mainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          showModalBottomSheet(
              //هذي حتخلي الصفحة تكبر على حسب العناصر اللي فيها
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
              context: context,
              builder: (cotext) => addProberty(ueserId: user!.uid));
          // Navigator.of(context).pushReplacementNamed('addPropertyScreen');
        },
        child: addButton(),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              currentP(),
              currentP(),
              currentP(),
              currentP(),
              currentP(),
            ],
          ),
        ),
      ),
    );
  }
}

class currentP extends StatelessWidget {
  const currentP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 411,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage('images/1012111.jpg'), fit: BoxFit.cover),
            ),
            child: pTitle(),
          ),
          edit_delete_Buttons(),
        ],
      ),
    );
  }
}

//this is the the title for the property that the PO had now
class pTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ' استراحة جميلة',
        style: TextStyle(color: Colors.white, fontSize: 40, shadows: <Shadow>[
          Shadow(
            offset: Offset(0, 0),
            color: Colors.black,
            blurRadius: 24.0,
          )
        ]),
      ),
    );
  }
}

class edit_delete_Buttons extends StatelessWidget {
  const edit_delete_Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: new Border.symmetric(
            horizontal: BorderSide(color: Colors.black, width: 3)),
        color: Colors.green.withOpacity(0),
      ),
      width: 411,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Center(
                              heightFactor: 1,
                              child: Text('هل تريد حذف العقار؟',
                                  style: KEditDeleteTextStyle)),
                          actions: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('لا',
                                        style: KEditDeleteTextStyle)),
                                SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('نعم',
                                        style: KEditDeleteTextStyle))
                              ],
                            ),
                          ],
                        ));
              },
              child: Text('حذف', style: KEditDeleteTextStyle)),
          TextButton(
              onPressed: () {},
              child: Text(
                'تعديل',
                style: KEditDeleteTextStyle,
              ))
        ],
      ),
    );
  }
}

class addButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add,
      color: Colors.black,
      size: 37,
    );
  }
}
