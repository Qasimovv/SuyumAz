import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:admin_suyumaz_app/common_widgets/custom_textformfield.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/services/validations.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:admin_suyumaz_app/utils/assets/urls.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final formKey = GlobalKey<FormState>();

  String taskName = "", cutomerName = "Sifarişçi";
  int selectedUser, selectedClient;
  String firstDate, lastDate = '2020-08-22 11:44', description;
  int maxLine = 1;
  FocusNode _fNode;
  List clientData = List();
  List userData = List();

  @override
  void initState() {
    super.initState();
    getClientList();
    getUserList();
    _fNode = FocusNode();
    TextEditingController textController1;
    textController1 = TextEditingController(
      text: "varsayılan",
    );
    _fNode.addListener(() {
      setState(() {
        if (_fNode.hasFocus)
          maxLine = 3;
        else
          maxLine = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40, top: 40),
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            Images.BLUE_LOGO,
                          ),
                        ),
                      ),
                      CustomTextField(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        onSaved: (data) {
                          taskName = data;
                        },
                        validatorFunction: Validations.validateName,
                        hintText: "İşin adı",
                      ),
//                      CustomTextField(
//                        padding: EdgeInsets.only(top: 15, bottom: 10),
//                        // validatorFunction: Validations.validateDate,
//                        hintText: "$firstDate",
//                        readOnly: true,
//                        onSaved: (data) {
//                          firstDate = data;
//                        },
//                        onTap: () {
//                          firstDialog(context);
//                        },
//                      ),
//                      CustomTextField(
//                        padding: EdgeInsets.only(top: 10, bottom: 10),
//                        hintText: "Bitme tarixi",
//                        readOnly: true,
//                        onSaved: (data) {
//                          setState(() {
//                            lastDate = data;
//                          });
//
//                        },
//                        onTap: () {
//                          lastDialog(context);
//
//                        },
//                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: buildDropdownButtonHideUnderlineUser()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 10),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: buildDropdownButtonHideUnderlineClient()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                  child: TextFormField(
                    autofocus: false,
                    maxLines: maxLine,
                    focusNode: _fNode,
                    validator: Validations.validateName,
                    onSaved: (data) {
                      setState(() {
                        description = data;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Təvir",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 60, right: 60, bottom: 10),
        child: GestureDetector(
            onTap: checkValidate,
            child: RaisedButton(
              shape: StadiumBorder(),
              onPressed: checkValidate,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )),
      ),
    );
  }

  void checkValidate() async {
    bool response;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      response =
          await addTask(selectedUser, selectedClient, description, lastDate);

      if (response != true) {
        showToast("Task əlavə oluna bilmədi.", Colors.red);
      } else {
        showToast("Task əlavə olundu.", Colors.blue);

        SetupRoutes.replaceScreen(context, Routes.ADDTASKPAGE);
      }
    }
  }

  void firstDialog(BuildContext context) {
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
                firstDate = datatime.year.toString() +
                    "/" +
                    datatime.month.toString() +
                    "/" +
                    datatime.day.toString();
              });
            },
          );
        });
  }

  lastDialog(BuildContext context) {
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
              setState(() {
                lastDate = datatime.year.toString() +
                    "/" +
                    datatime.month.toString() +
                    "/" +
                    datatime.day.toString();
              });
              setState(() {
                lastDate = lastDate;
              });
            },
          );
        });
  }

  DropdownButtonHideUnderline buildDropdownButtonHideUnderlineClient() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: clientData.map((item) {
          return new DropdownMenuItem(
            child: new Text(item['fullName']),
            value: item['id'],
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            selectedClient = newVal;
          });
        },
        value: selectedClient,
        hint: Text("Müştəri seçin."),
      ),
    );
  }

  DropdownButtonHideUnderline buildDropdownButtonHideUnderlineUser() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: userData.map((item) {
          return new DropdownMenuItem(
            child: new Text(item['fullName']),
            value: item['id'],
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            selectedUser = newVal;
          });
        },
        value: selectedUser,
        hint: Text("İşçi seçin."),
      ),
    );
  }

  Future<String> getClientList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final http.Response response =
        await http.get(Urls.CLIENT_LIST_URL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('Authorization'),
    });
    var resBody = json.decode(response.body);

    setState(() {
      clientData = resBody;
    });
    return 'Success';
  }

  Future<String> getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final http.Response response =
        await http.get(Urls.USER_LIST_URL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('Authorization'),
    });
    var resBody = json.decode(response.body);

    setState(() {
      userData = resBody;
    });
    return 'Success';
  }
}
