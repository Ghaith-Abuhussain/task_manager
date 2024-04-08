import 'add_task_request_body.dart';

class AddTaskRequest {
  final String? token;
  final AddTaskRequestBody? body;


  AddTaskRequest({
    required this.body,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    'body': body!.toJson(),
    'token': token,
  };
}
