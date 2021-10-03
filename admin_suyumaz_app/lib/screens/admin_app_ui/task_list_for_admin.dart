import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin_suyumaz_app/models/task_model/task_model.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'dart:convert';
import 'package:admin_suyumaz_app/utils/assets/urls.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListforAdmin extends StatefulWidget {
  @override
  _TaskListforAdminState createState() => _TaskListforAdminState();
}

class _TaskListforAdminState extends State<TaskListforAdmin> {
  List userData = List();
  int selectedUser;

  var test;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TaskModel>>(
        future: getTaskList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TaskModel> data = snapshot.data;
            return _jobsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index].client.fullName,
              data[index].createdTime,
              data[index].willExpireAt,
              data[index].id,
              data[index].status,
              data[index].assignedTo.fullName,
              data[index].description,
              data[index].client.address.addressLine);
        });
  }

  Card _tile(String clientName, String createdTime, String willExpireAt, int id,
          String status, String username, String description, String address) =>
      Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Müraciət",
                    style: TextStyle(fontSize: 24, color: Color(0xff00008B)),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "İşçi adi:  $username ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sifarişçi:  $clientName",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Başlama tarixi:  $createdTime",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bitmə tarixi:  $willExpireAt",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Address:  $address",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Təsvir:  $description",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
              terminateorChangeUser(id, status)
            ],
          ),
        ),
      );

  openAlertBox(int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content:
            Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: buildDropdownButtonHideUnderlineUser(id)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: SizedBox(
                      height: 40,
                    ),
                  ),

                ],
              ),
            ),
          );
        });
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


  DropdownButtonHideUnderline buildDropdownButtonHideUnderlineUser(id) {
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
              changeUser(id, selectedUser);
              Navigator.pop(context);

          });
        },
        value: selectedUser,
        hint: Text("İşçi  seçin."),
      ),
    );
  }

  Row terminateorChangeUser(int id, String status) {
    switch (status) {
      case "TERMINATED":
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$status",
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: RaisedButton(
//                shape: StadiumBorder(),
//                onPressed: () {
//                  openAlertBox(id);
//                  //
//                },
//                color: Colors.green,
//                child: Padding(
//                  padding: const EdgeInsets.all(7.0),
//                  child: Text(
//                    "Change USER",
//                    style: TextStyle(
//                        fontSize: 12,
//                        color: Colors.white,
//                        fontWeight: FontWeight.normal),
//                  ),
//                ),
//              ),
//            ),
          ],
        );
        break;
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  onPressed: () {
                    terminate(id);
                  },
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      "Terminate",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                )),
            Text(
              "$status",
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {
              openAlertBox(id);
                },
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Change USER",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
    }
  }

  terminate(int id) async {
    var response;

    response = await terminateTask(id);
    if (response != null) {
      showToast("terminated", Colors.blue);
      SetupRoutes.replaceScreen(context, Routes.TASKLISTFORADMIN);
    } else {
      showToast("promlem yasandi.", Colors.red);
    }
  }

  changeUser(int id, int userId) async {
    String response = await changeTaskUser(id, userId);
    if (response != null) {
      showToast("İşçi dəyişdirildi.", Colors.blue);
      SetupRoutes.replaceScreen(context, Routes.TASKLISTFORADMIN);
    } else {
      showToast("İşçi dəyişdirilə bilmədi.", Colors.red);
    }
  }
}
