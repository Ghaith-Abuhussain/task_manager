import 'package:task_managing/data/datasources/remote/api/task_manager_api_service.dart';

import '../../../domain/models/remote/requests/signup/sign_up_request.dart';
import '../../../domain/models/remote/responses/signup/sign_up_response.dart';
import '../../../domain/repositories/remote/sign_up_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../../base/base_api_repository.dart';

class SignUpRepositoryImpl extends BaseApiRepository implements SignUpRepository {
  final TaskManagerApiService _taskManagerApiService;

  SignUpRepositoryImpl(this._taskManagerApiService);
  @override
  Future<DataState<SignUpResponse>> signUp({required SignUpRequest request}) {

    return getStateOf<SignUpResponse>(
      request: () => _taskManagerApiService.signUp(
          body: request,
      ),
    );

  }
  
}