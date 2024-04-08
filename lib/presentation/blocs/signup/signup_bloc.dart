import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../utils/resources/data_state.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import '../../../domain/repositories/remote/sign_up_repository.dart';
import '../../../domain/models/remote/responses/signup/sign_up_response.dart';
import '../../../domain/models/remote/requests/signup/sign_up_request.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository signUpRepository;

  SignUpBloc(this.signUpRepository) : super(SignUpStateInitial()) {
    on<SignUpEventSignUp>((event, emit) async {
      SignUpRequest request =
          SignUpRequest(email: event.email, password: event.password);

      emit(SignUpStateWaitingForSignUp());
      bool result = await InternetConnectionChecker().hasConnection;
      if(result == true) {
        DataState<SignUpResponse> response =
        await signUpRepository.signUp(request: request);

        if (response is DataSuccess) {
          emit(SignUpStateSignUpSuccess());
        } else if (response is DataFailed) {
          emit(SignUpStateSignUpFailure());
        }
      } else {
        emit(SignUpStateSignUpFailure());
      }


    });
    on<SignUpRequestSmsAuth>((event, emit) async {});
    on<SignUpVerifyPhoneNumber>((event, emit) async {});
  }
}
