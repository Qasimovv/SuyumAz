import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin_suyumaz_app/models/task_model/task_model.dart';
import 'dart:convert';
import 'package:admin_suyumaz_app/models/user_model.dart';
import 'package:admin_suyumaz_app/utils/assets/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<User> login(
  String username,
  String password,
) async {
  final http.Response response = await http.post(
    Urls.LOGIN_URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return User.fromJson(response.headers);
  } else {
    return null;
  }
}

register(
  String username,
  String password,
  String name,
  String surName,
) async {
  final http.Response response = await http.post(
    Urls.REGISTER_URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'name': name,
      'surname': surName,
    }),
  );

  print(response.statusCode.toString());
  if (response.statusCode == 201)
    return true;
  else
    return null;
}

addClient(
  String name,
  String surname,
  String email,
  String coordinates,
  String addressLine,
  String addressDetails,
  String mobile,
  String phone,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.post(
    Urls.ADD_CLIENT,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('Authorization'),
    },
    body: jsonEncode(<String, String>{
      "name": name,
      "surname": surname,
      "addressLine": addressLine,
      "coordinates": coordinates,
      "addressDetails": addressDetails,
      "mobile": mobile,
      "phone": phone,
      "email": email
    }),
  );

  print(response.statusCode.toString());
  if (response.statusCode == 201)
    return true;
  else
    return null;
}

addTask(
  int assignedToId,
  int clientId,
  String description,
  String willExpireAt,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final http.Response response = await http.post(
    Urls.ADD_TASK_URL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': prefs.getString('Authorization'),
    },
    body: jsonEncode(<String, dynamic>{
      'ownerId': 1,
      'assignedToId': assignedToId,
      'clientId': clientId,
      'description': description,
      'willExpireAt': willExpireAt,
    }),
  );

  print(response.statusCode.toString());
  if (response.statusCode == 201)
    return true;
  else
    return null;
}

Future<List<TaskModel>> getTaskList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(Urls.TASK_LIST, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new TaskModel.fromJsonMap(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

rejectTask(int taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = Urls.REJECT_TASK + '/$taskId';
  final response = await http.put(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  print(response.statusCode.toString());
  if (response.statusCode == 202)
    return true;
  else
    return false;
}

acceptTask(int taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final url = Urls.ACCEPT_TASK + '/$taskId';
  final response = await http.put(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  print(response.statusCode.toString());
  if (response.statusCode == 202)
    return true;
  else
    return false;
}

completeTask(int taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = Urls.COMPLETE_TASK + '/$taskId';
  final response = await http.put(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  print(response.statusCode.toString());
  if (response.statusCode == 202)
    return true;
  else
    return false;
}

terminateTask(int taskId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = Urls.TERMINATE_TASK + '/$taskId';
  final response = await http.put(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  print(response.statusCode.toString());
  if (response.statusCode == 202)
    return true;
  else
    return null;
}

changeTaskUser(int taskId, int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = Urls.CHANGE_USER + '/$taskId/to/$userId';
  final response = await http.put(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': prefs.getString('Authorization'),
  });

  print(response.statusCode.toString());
  if (response.statusCode == 202)
    return true;
   else
    return null;

}

showToast(String value, Color color) {
  return Fluttertoast.showToast(
      msg: value,

      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 12.0);
}
