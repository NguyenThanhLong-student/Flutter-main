import 'package:flutter/material.dart';
import 'package:login_with_signup/Comm/comHelper.dart';
import 'package:login_with_signup/Comm/genLoginSignupHeader.dart';
import 'package:login_with_signup/Comm/genTextFormField.dart';
import 'package:login_with_signup/DatabaseHandler/DbHelper.dart';
import 'package:login_with_signup/Model/CarModel.dart';
import 'package:login_with_signup/Screens/CarsForm.dart';

class AddCarForm extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCarForm> {
  final _formKey = new GlobalKey<FormState>();

  final _make = TextEditingController();
  final _model = TextEditingController();
  final _description = TextEditingController();
  final _imageSrc = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  AddCarFunc() async {
    String make = _make.text;
    String model = _model.text;
    String description = _description.text;
    String imageSrc = _imageSrc.text;

    if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        CarModel carModel = CarModel(make, model, description, imageSrc);
        await dbHelper.saveCars(carModel).then((carData) {
          alertDialog(context, "Successfully Saved");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CarList()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error: Data Save Fail");
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add car'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Add Car'),
                  getTextFormField(
                      controller: _make,
                      icon: Icons.person,
                      hintName: 'Brand'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _model,
                      icon: Icons.car_rental,
                      inputType: TextInputType.name,
                      hintName: 'Car Model'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _description,
                      icon: Icons.pages,
                      hintName: 'Description'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _imageSrc,
                    icon: Icons.image,
                    hintName: 'Image',
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Add Car',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: AddCarFunc,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
