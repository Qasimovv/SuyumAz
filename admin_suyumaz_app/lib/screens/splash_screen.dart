import 'dart:async';
import 'package:admin_suyumaz_app/services/sizeconfig.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_auth_db/lib_auth_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Completer _completer = new Completer();

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    wait();
    checkIfLanguageSelected();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000000),
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          Images.Splas,
          height: SizeConfig.getHeightRatio(153),
          width: SizeConfig.getWidthRatio(258),
        ),
      ),
    );
  }
  checkIfLanguageSelected() async {
    DBResponse res = await DBService().getString(key: "homeBackgroundImage");
//    await Provider.of<ThemeProvider>(context)
//        .setImage(res.data ?? Images.BACKGROUND_IMAGE);
    if (!_completer.isCompleted) await _completer.future;
  }
  wait() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      _completer.complete();
    });
  }
  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('Authorization').toString());
    if (prefs.getString('Authorization') != null) {
      Navigator.pushReplacementNamed(context, Routes.MAINPAGE);
    } else {
      Navigator.pushReplacementNamed(context, Routes.LOGINPAGE);
    }
  }
}
