
import 'package:admin_suyumaz_app/utils/constants/db_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_auth_db/lib_auth_db.dart';
import 'app.dart';
import 'localization/init_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, dynamic> localizedValues = await initLocalization();
  DBResponse response = await DBService().getString(key: "language");
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DBService().create(dbItems);
  runApp(MyApp(localizedValues, response.data));
}
