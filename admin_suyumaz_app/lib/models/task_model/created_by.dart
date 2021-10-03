
class CreatedBy {

  int id;
  String username;
  String fullName;

	CreatedBy.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		username = map["username"],
		fullName = map["fullName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['username'] = username;
		data['fullName'] = fullName;
		return data;
	}
}
