import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:admin_suyumaz_app/common_widgets/custom_textformfield.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/services/validations.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String numberValue = "050";
  Future _futureUser;

//  String genderValue = "Cinsinizi seçin";
  String date = "Doğum tarixi";
  String _number, _numberCode, _date, _gender;
  final formKey = GlobalKey<FormState>();
  String name, surName, username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,

//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        leading: Icon(
//          Icons.arrow_back_ios,
//          color: Colors.black,
//        ),
//      ),
      body: Form(
        key: formKey,
        autovalidate: false,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
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
                      validatorFunction: Validations.validateName,
                      hintText: "Ad"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          surName = data;
                        });
                      },
                      validatorFunction: Validations.validateName,
                      hintText: "Soyad"),

//                  Padding(
//                    padding: const EdgeInsets.all(10),
//                    child: Container(
//                      child: Row(
//                        children: <Widget>[
//                          Container(
//                              height: 60,
//                              width: 100,
//                              decoration: BoxDecoration(
//                                  border: Border.all(
//                                    color: Colors.grey,
//                                    width: 1,
//                                  ),
//                                  borderRadius: BorderRadius.circular(8)),
//                              child: buildDropdownButtonHideUnderline()),
//                          Expanded(
//                            child: Container(
//                              padding: EdgeInsets.only(left: 10),
//                              width: 300,
//                              //height: 60,
//                              child: CustomTextField(
//                                padding: EdgeInsets.only(left: 10),
//                                maxLength: 7,
//                                keyboardType: TextInputType.number,
//                                onSaved: (data) {
//                                  _number = data;
//                                },
//                                validatorFunction:
//                                    Validations.validateCellPhone,
//                                hintText: "Phone",
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  CustomTextField(
//                    padding: EdgeInsets.all(10),
//                    validatorFunction: Validations.validateName,
//                    hintText: "Doğum tarixi",
//                    readOnly: true,
//                    onSaved: (data) {
//                      _soyAd = data;
//                    },
//                    onTap: () {
//                      dialog(context);
//                    },
//                  ),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          password = data;
                        });
                      },
                      validatorFunction: Validations.validatePassword,
                      hintText: "Şifrə"),
                  CustomTextField(
                      padding: EdgeInsets.all(10),
                      onSaved: (data) {
                        setState(() {
                          username = data;
                        });
                      },
                      validatorFunction: Validations.validatePassword,
                      hintText: "Username"),

//                  Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: buildContainerforGender(),
//                  ),
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

//  Container buildContainerforGender() {
//    return Container(
//        height: 60,
//        width: double.infinity,
//        decoration: BoxDecoration(
//            border: Border.all(
//              color: Colors.grey,
//              width: 1,
//            ),
//            borderRadius: BorderRadius.circular(8)),
//        child: DropdownButtonHideUnderline(
//          child: DropdownButton(
//              icon: Icon(Icons.keyboard_arrow_down),
//              value: "$genderValue",
//              items: <String>['Cinsinizi seçin', 'Kişi', 'Qadın']
//                  .map((String value) {
//                return DropdownMenuItem<String>(
//                  value: value,
//                  child: Text("   $value"),
//                );
//              }).toList(),
//              onChanged: (value) {
//                setState(() {
//                  genderValue = value;
//                });
//              }),
//        ));
//  }

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


      response = await register(username, password, name, surName);



      if (response == true) {
        showToast("istifadəçi yaradıldı.", Colors.green);

        SetupRoutes.replaceScreen(context, Routes.REGISTERPAGE);
      } else {
        showToast("İstifadəçi  yaradıla bilmədi.", Colors.red);
      }
    }
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DatePickerWidget(
// dateFormat: 'mm-dd-yyyy',
//          onChange: (dateTime, selectedIndex) {
//
//          },
            onConfirm: (datatime, selectedindex) {
              print('${datatime.year} / ${datatime.month} /${datatime.day} ');
              setState(() {
                date = datatime.year.toString() +
                    "/" +
                    datatime.month.toString() +
                    "/" +
                    datatime.day.toString();
              });
            },
          );
        });
  }
}
