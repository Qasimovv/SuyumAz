import 'package:admin_suyumaz_app/routes/routes.dart';
import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:admin_suyumaz_app/utils/constants/network_util.dart';
import 'package:admin_suyumaz_app/utils/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Set<String> pageNames = {
    'İşçi əlave et',
    'Müştəri əlave et',
    'Tapşırıq əlave et',
    'Tapşırıqlar'
     'Çıxış'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  width: double.infinity,
                  color: Color(0xFF003399),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.asset(Images.APP_WHITE_ICON),
                  ))),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: 5,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext contex, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      changePage(index);
                    },
                    child: Card(
                      elevation: 3,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          child: Column(
                            children: <Widget>[
                              addIcon(index),
                              (index!=4)?Text(
                                pageNames.elementAt(index),
                                style: TextStyle(fontSize: 24),
                              ):SizedBox(),
                            ],
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  changePage(int index) {
    switch (index) {
      case 0:
        SetupRoutes.changeScreen(context, Routes.REGISTERPAGE);

        break;
      case 1:
        SetupRoutes.changeScreen(context, Routes.ADDCLIENT);
        break;
      case 2:
        SetupRoutes.changeScreen(context, Routes.ADDTASKPAGE);
        break;
      case 3:
        SetupRoutes.changeScreen(context, Routes.TASKLISTFORADMIN);
        break;
      case 4:
        removeSharedPreferences();
        break;
    }
  }

  addIcon(int index) {
    switch (index) {
      case 0:
        return Icon(
          Icons.person_add,
          color: Colors.blue,
          size: 40,
        );

        break;
      case 1:
        return Icon(
          Icons.person_add,
          color: Colors.orange,
          size: 40,
        );
        break;
      case 2:
        return Icon(
          Icons.library_add,
          color: Colors.blue,
          size: 40,
        );
        break;
      case 3:
        return Icon(
          Icons.list,
          color: Colors.blue,
          size: 40,
        );
        break;
      case 4:
        return Center(
          child: Icon(
            Icons.power_settings_new,
            color: Colors.red,
            size: 80,
          ),
        );
        break;
    }
  }

  removeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("Authorization");
    SetupRoutes.replaceScreen(context, Routes.LOGINPAGE);
  }
}
