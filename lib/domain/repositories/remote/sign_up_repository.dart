import '../../../utils/resources/data_state.dart';
import '../../models/remote/requests/signup/sign_up_request.dart';
import '../../models/remote/responses/signup/sign_up_response.dart';

abstract class SignUpRepository {
  Future<DataState<SignUpResponse>> signUp({
    required SignUpRequest request,
  });
}