import 'package:task_managing/data/datasources/remote/api/task_manager_api_service.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/delete_task/delete_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/edit_task/edit_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/get_page/get_page_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_task/add_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/edit_task/edit_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/get_page_response.dart';

import '../../../domain/repositories/remote/get_info_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../../base/base_api_repository.dart';

class GetInfoRepositoryImpl extends BaseApiRepository
    implements GetInfoRepository {
  final TaskManagerApiService _taskManagerApiService;

  GetInfoRepositoryImpl(this._taskManagerApiService);

  @override
  Future<DataState<GetPageResponse>> getPage(
      {required GetPageRequest request}) {
    return getStateOf<GetPageResponse>(
      request: () => _taskManagerApiService.getPage(
          request.token!, request.pageNumber!.toString()),
    );
  }

  @override
  Future<DataState<String?>> deleteTask({required DeleteTaskRequest request}) {
    return getStateOf<String?>(
      request: () => _taskManagerApiService.deleteTask(
          request.token!, request.taskNumber.toString()),
    );
  }

  @override
  Future<DataState<EditTaskResponse>> editTask(
      {required EditTaskRequest request}) {
    return getStateOf<EditTaskResponse>(
      request: () => _taskManagerApiService.editTask(
          token: request.token, body: request.body, id: request.id.toString()),
    );
  }

  @override
  Future<DataState<AddTaskResponse>> addTask(
      {required AddTaskRequest request}) {
    return getStateOf<AddTaskResponse>(
      request: () => _taskManagerApiService.addTask(
          token: request.token, body: request.body),
    );
  }
}
