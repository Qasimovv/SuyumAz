
class Address {

  String addressLine;
  String coordinate;
  String details;

	Address.fromJsonMap(Map<String, dynamic> map): 
		addressLine = map["addressLine"],
		coordinate = map["coordinate"],
		details = map["details"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['addressLine'] = addressLine;
		data['coordinate'] = coordinate;
		data['details'] = details;
		return data;
	}
}
