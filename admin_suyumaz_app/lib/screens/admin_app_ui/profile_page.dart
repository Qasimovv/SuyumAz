import 'package:admin_suyumaz_app/utils/assets/images.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 65),
          child: Text(
            'Profile',
            textAlign: TextAlign.justify,
          ),
        )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF003399),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Color(0xFF003399),
                boxShadow: [
                  BoxShadow(spreadRadius: 1),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      Images.PROFILE_ICON,
                    ),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emilia Aghayeva",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "aghayeva@gmail.com",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text("Name", style: TextStyle(color: Colors.grey)),
        ),
        subtitle: Text(
          "Elnur",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
