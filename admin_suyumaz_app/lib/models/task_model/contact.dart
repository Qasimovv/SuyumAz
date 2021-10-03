
class Contact {

  String mobile;
  String phone;
  String email;

	Contact.fromJsonMap(Map<String, dynamic> map): 
		mobile = map["mobile"],
		phone = map["phone"],
		email = map["email"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mobile'] = mobile;
		data['phone'] = phone;
		data['email'] = email;
		return data;
	}
}
