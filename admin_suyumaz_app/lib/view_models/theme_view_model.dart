import 'package:admin_suyumaz_app/models/base_model.dart';
import 'package:lib_auth_db/lib_auth_db.dart';

class ThemeProvider extends BaseModel {
  String _homeBackgroundImage;
  ThemeProvider();

  Future setImage(String text) async {
    await DBService().putString(key: "homeBackgroundImage", value: text);
    _homeBackgroundImage = text;
    notifyListeners();
  }

  String get getImage => _homeBackgroundImage;
}
