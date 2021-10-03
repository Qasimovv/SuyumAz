
import 'package:shared_preferences/shared_preferences.dart';

class User {

  final String authorization;

  User({ this.authorization});

  factory User.fromJson(Map<String, dynamic> json) {

    return User(

      authorization: json['authorization'],
    );
  }
}