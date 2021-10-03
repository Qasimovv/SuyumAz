import 'package:admin_suyumaz_app/localization/app_localization.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  var appLocal;

  @override
  Widget build(BuildContext context) {
    appLocal = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.REGISTERPAGE);
              },
              color: Colors.green,
              child: Text("RegisterPage"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.LOGINPAGE);
              },
              color: Colors.blue,
              child: Text("LoginPage"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.PRIFILEPAGE);
              },
              color: Colors.green,
              child: Text("ProfilePAge"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.MAINPAGE);
              },
              color: Colors.green,
              child: Text("MainPage"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.ADDTASKPAGE);
              },
              color: Colors.green,
              child: Text("ADD TASK"),
            ),
            FlatButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/MainPage");
                SetupRoutes.changeScreen(context, Routes.TASKS);
              },
              color: Colors.green,
              child: Text("TASKS"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.ADDCLIENT);
              },
              color: Colors.green,
              child: Text("ADD CLIENT"),
            ),
            FlatButton(
              onPressed: () {
                SetupRoutes.changeScreen(context, Routes.TASKLISTFORADMIN);
              },
              color: Colors.green,
              child: Text("Task List for Admin"),
            ),
            FlatButton(
              onPressed: () {
                removeSharedPreferences();
              },
              color: Colors.green,
              child: Text("LOg Out"),
            ),
            FlatButton(
              onPressed: () {
                showToast("test",Colors.teal);
              },
              color: Colors.green,
              child: Text("toast"),
            ),
          ],
        ),
      ),
    );
  }
  removeSharedPreferences()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("Authorization");
    SetupRoutes.changeScreen(context, Routes.LOGINPAGE);

  }



}
