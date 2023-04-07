import 'package:flutter/material.dart';

import '../../constants.dart';

class addProberty extends StatefulWidget {
  const addProberty({Key? key}) : super(key: key);

  @override
  State<addProberty> createState() => _addProbertyState();
}

class _addProbertyState extends State<addProberty> {
  List<String> _cityList=['بنغازي','طرابلس'];
  String? _selectedCity='بنغازي';
  List<String> _areaList=['الكيش','الحدائق'];
  String? _selectedArea='الكيش';
  final _mainLableControler=TextEditingController() ;
 final _priceControler=TextEditingController() ;
  int _probertyType= 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'LyLand',
          style: kTitleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // main lable text field
            TextField(
              controller: _mainLableControler,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'ادخل العنوان الرئيسي',
                label: Text('عنوان رئيسي :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 15.0,),

            // row for radio buttons
            Row(
              children: [
                Radio(value: 1,
                    groupValue: _probertyType,
                    onChanged: (value){
                  setState(() {
                    _probertyType=value!;
                  });
                }),
                SizedBox(width: 10.0,),
                Text('شقة',style: kTitleTextStyle,),
                Radio(value: 2,
                    groupValue: _probertyType,
                    onChanged: (value){
                      setState(() {
                        _probertyType=value!;
                      });
                    }),
                SizedBox(width: 10.0,),
                Text('استراحة',style: kTitleTextStyle,),
                Radio(value: 3,
                    groupValue: _probertyType,
                    onChanged: (value){
                      setState(() {
                        _probertyType=value!;
                      });
                    }),
                SizedBox(width: 10.0,),
                Text('شاليه',style: kTitleTextStyle,)
              ],
            ),



            //drop down menu for the city
            SizedBox(height: 15.0,),
            DropdownButton<String>(
              value: _selectedCity,
                items: _cityList.map((item) => DropdownMenuItem(
                  value: item,
                    child: Text(item,style: kTitleTextStyle,)
                  ,)
                  ,).toList(),
                 onChanged: (item)=> setState(()=>_selectedCity=item),
            ),

            // drop down menu for the area
            SizedBox(height: 15.0,),
            DropdownButton<String>(
              value: _selectedArea,
              items: _areaList.map((item) => DropdownMenuItem(
                value: item,
                child: Text(item,style: kTitleTextStyle,)
                ,)
                ,).toList(),
              onChanged: (item)=> setState(()=>_selectedCity=item),
            ),

            // text field for the price
            SizedBox(height: 15.0,),
            TextField(
              controller: _priceControler,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'ادخل سعر الايجار لليلة الواحدة',
                label: Text('السعر :',style: kTitleTextStyle,),
              ),
            ),


          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey[800]),
                      elevation: MaterialStatePropertyAll(10.0),
                      shadowColor: MaterialStatePropertyAll(Colors.orange)
                  ),
                  onPressed:(){
                    Navigator.of(context).pushReplacementNamed('POwnerScreen');
                  },
                  child: Text('Save',style: kTitleTextStyle,)
              ),
              SizedBox(width: 10.0,),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey[800]),
                      elevation: MaterialStatePropertyAll(10.0),
                      shadowColor: MaterialStatePropertyAll(Colors.orange)
                  ),
                  onPressed:(){
                    Navigator.of(context).pushReplacementNamed('POwnerScreen');
                  },
                  child: Text('cancel',style: kTitleTextStyle,)
              ),
            ],
          ),
        )

    );
  }
}
