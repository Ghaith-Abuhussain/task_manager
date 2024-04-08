import 'edit_task_request_body.dart';

class EditTaskRequest {
  final int? id;
  final String? token;
  final EditTaskRequestBody? body;


  EditTaskRequest({
    required this.id,
    required this.body,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    'body': body!.toJson(),
    'id': id,
    'token': token,
  };
}
