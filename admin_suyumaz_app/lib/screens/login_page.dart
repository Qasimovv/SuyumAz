import 'package:admin_suyumaz_app/models/user_model.dart';
import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/services/validations.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences prefs;
  bool _isLoading = false;
  User _futureUser;
  String numberValue = "050";
  bool _showPassword = false;
  final formKey = GlobalKey<FormState>();

  String _userName;
  String _password;

  @override
  void initState()  {
    test();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MoonLight",
      home: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage(Images.BACKGROUND_IMAGE),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: formKey,
              autovalidate: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(18),
                            child: TextFormField(
                              onSaved: (data) {
                                _userName = data;
                              },
                              validator: Validations.validateUserName,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.account_circle),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  hintText: "İstifadəçi adı."),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 18, bottom: 18, right: 18),
                            child: TextFormField(
                              onSaved: (data) {
                                _password = data;
                              },
                              validator: Validations.validatePassword,
                              obscureText: !this._showPassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      this._showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() => this._showPassword =
                                          !this._showPassword);
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  hintText: "Şifrə"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: GestureDetector(
              onTap: checkValidate,
              child: Image.asset(Images.WHITE_BUTTON),
            ),
          )
//            : buildFutureBuilder(),
          ),
    );
  }

//  FutureBuilder<User> buildFutureBuilder() {
//    return FutureBuilder<User>(
//      future: _futureUser,
//      builder: (context, snapshot) {
//        print(snapshot.hasData.toString());
//        if (snapshot.hasData) {
//          return MainPage();
//        } else if (snapshot.hasError) {}
//
//        return Container(
//          height: 20,
//          width: 20,
//          child: CircularProgressIndicator(),
//        );
//      },
//    );
//  }

//  DropdownButtonHideUnderline buildDropdownButtonHideUnderline() {
//    return DropdownButtonHideUnderline(
//      child: DropdownButton(
//          icon: Icon(
//            Icons.keyboard_arrow_down,
//            color: Colors.blue,
//          ),
//          value: "$numberValue",
//          items:
//              <String>['050', '051', '055', '070', '077'].map((String value) {
//            return DropdownMenuItem<String>(
//              value: value,
//              child: Text("    $value"),
//            );
//          }).toList(),
//          onChanged: (value) {
//            setState(() {
//              numberValue = value;
//            });
//          }),
//    );
//  }
  void checkValidate() async {
    User response;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      response = (await login(_userName, _password));
      if (response == null) {
        showToast("İstifadəçi adı və ya parol səhvdir",Colors.red);

      } else {
        setState(() {
          _futureUser = response;
        });
        prefs.setString('Authorization', response.authorization);
        SetupRoutes.changeScreen(context, Routes.MAINPAGE);
      }
    }
  }
  test()async{
    prefs = await SharedPreferences.getInstance();

  }

}
