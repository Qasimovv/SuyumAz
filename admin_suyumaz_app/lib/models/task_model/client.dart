import 'package:admin_suyumaz_app/models/task_model/address.dart';
import 'package:admin_suyumaz_app/models/task_model/contact.dart';

class Client {

  int id;
  Address address;
  Contact contact;
  String fullName;

	Client.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		address = Address.fromJsonMap(map["address"]),
		contact = Contact.fromJsonMap(map["contact"]),
		fullName = map["fullName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['address'] = address == null ? null : address.toJson();
		data['contact'] = contact == null ? null : contact.toJson();
		data['fullName'] = fullName;
		return data;
	}
}
