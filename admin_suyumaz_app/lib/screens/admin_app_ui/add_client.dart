import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:admin_suyumaz_app/common_widgets/custom_textformfield.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/services/validations.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AddClient extends StatefulWidget {
  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  String numberValue = "050";
  final formKey = GlobalKey<FormState>();
  String name, surName, addressLine, addressDetails, email;
  String coordinates = '1246,263828';
  String mobile;

  String phone = "121212121212";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidate: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60.0, bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(Images.BLUE_LOGO),
                    ),
                  ),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          name = data;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validatorFunction: Validations.validateName,
                      hintText: "Ad"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          surName = data;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validatorFunction: Validations.validateSurName,
                      hintText: "Soy Ad"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          email = data;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      validatorFunction: Validations.validateEmail,
                      hintText: "Email"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          addressLine = data;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validatorFunction: Validations.validateAddress,
                      hintText: "Adrees Line"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          addressDetails = data;
                        });
                      },
                      keyboardType: TextInputType.text,
                      validatorFunction: Validations.validateAddress,
                      hintText: "Address detail"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: buildDropdownButtonHideUnderline()),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              width: 300,
                              //height: 60,
                              child: CustomTextField(
                                padding: EdgeInsets.only(left: 10),
                                maxLength: 7,
                                keyboardType: TextInputType.number,
                                onSaved: (data) {
                                  mobile = data;
                                },
                                validatorFunction:
                                    Validations.validateCellPhone,
                                hintText: "Nömrə",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          phone = data;
                        });
                      },

                      validatorFunction: Validations.validateCellPhone,
                      hintText: "Ev telefonu"),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: checkValidate,
        child: Image.asset(Images.GREEN_BUTTON),
      ),
    );
  }

  DropdownButtonHideUnderline buildDropdownButtonHideUnderline() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down),
          value: "$numberValue",
          items:
              <String>['050', '051', '055', '070', '077'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text("   $value"),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              numberValue = value;
            });
          }),
    );
  }

  void checkValidate() async {
    bool response;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      response=await addClient(name, surName, email, coordinates, addressLine, addressDetails, mobile, phone);

      if (response != true) {
        showToast("Client əlavə edilə bilmədi.", Colors.red);
      } else {
        showToast("Client əlavə olundu.", Colors.blue);

        SetupRoutes.replaceScreen(context, Routes.ADDCLIENT);
      }
    }
  }
}
