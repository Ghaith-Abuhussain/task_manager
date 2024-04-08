import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_task/add_task_response.dart';

import '../../../utils/resources/data_state.dart';
import '../../models/remote/requests/delete_task/delete_task_request.dart';
import '../../models/remote/requests/edit_task/edit_task_request.dart';
import '../../models/remote/requests/get_page/get_page_request.dart';
import '../../models/remote/responses/edit_task/edit_task_response.dart';
import '../../models/remote/responses/get_page/get_page_response.dart';

abstract class GetInfoRepository {
  Future<DataState<GetPageResponse>> getPage({
    required GetPageRequest request,
  });

  Future<DataState<EditTaskResponse>> editTask(
      {required EditTaskRequest request});

  Future<DataState<String?>> deleteTask({required DeleteTaskRequest request});

  Future<DataState<AddTaskResponse>> addTask({required AddTaskRequest request});
}
