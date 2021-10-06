
import 'package:admin_suyumaz_app/screens/admin_app_ui/add_client.dart';
import 'package:admin_suyumaz_app/screens/admin_app_ui/add_task.dart';
import 'package:admin_suyumaz_app/screens/admin_app_ui/main_page.dart';
import 'package:admin_suyumaz_app/screens/admin_app_ui/register_page.dart';
import 'package:admin_suyumaz_app/screens/admin_app_ui/task_list_for_admin.dart';

import 'package:admin_suyumaz_app/screens/login_page.dart';
import 'package:admin_suyumaz_app/screens/main_screens/route.dart';
import 'package:admin_suyumaz_app/screens/splash_screen.dart';
import 'package:admin_suyumaz_app/screens/admin_app_ui/profile_page.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';


import 'package:flutter/material.dart';

class SetupRoutes {
  // Set initial route here
  static String initialRoute = Routes.SPLASH;

  /// Add entry for new route here
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.SPLASH: (context) => SplashScreen(),


      //auth
      Routes.REGISTERPAGE: (context) => RegisterPage(),
      Routes.LOGINPAGE: (context) => LoginPage(),
      
      
      //other
      Routes.MAIN_PAGE: (context) => RoutePage(),
      Routes.MAINPAGE: (context) => MainPage(),
      Routes.PRIFILEPAGE: (context) => ProfilePage(),
      Routes.ADDTASKPAGE: (context) => AddTask(),
      Routes.ADDCLIENT: (context) => AddClient(),
      Routes.TASKLISTFORADMIN: (context) => TaskListforAdmin(),
    };
  }





  static Future changeScreen(BuildContext context, String value,
      {Object arguments}) {
    return Navigator.pushNamed(context, value, arguments: arguments);
  }

  static replaceScreen(BuildContext context, String value,
      {dynamic arguments}) {
    Navigator.of(context).pushReplacementNamed(value, arguments: arguments);
  }
}
