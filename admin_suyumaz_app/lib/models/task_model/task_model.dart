import 'package:admin_suyumaz_app/models/task_model/created_by.dart';
import 'package:admin_suyumaz_app/models/task_model/assigned_to.dart';
import 'package:admin_suyumaz_app/models/task_model/client.dart';

class TaskModel {

  int id;
  String description;
  String status;
  CreatedBy createdBy;
  AssignedTo assignedTo;
  Client client;
  String willExpireAt;
  String createdTime;

	TaskModel.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		description = map["description"],
		status = map["status"],
		createdBy = CreatedBy.fromJsonMap(map["createdBy"]),
		assignedTo = AssignedTo.fromJsonMap(map["assignedTo"]),
		client = Client.fromJsonMap(map["client"]),
		willExpireAt = map["willExpireAt"],
		createdTime = map["createdTime"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['description'] = description;
		data['status'] = status;
		data['createdBy'] = createdBy == null ? null : createdBy.toJson();
		data['assignedTo'] = assignedTo == null ? null : assignedTo.toJson();
		data['client'] = client == null ? null : client.toJson();
		data['willExpireAt'] = willExpireAt;
		data['createdTime'] = createdTime;
		return data;
	}
}
