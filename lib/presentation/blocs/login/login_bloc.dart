import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/local/task.dart';
import '../../../domain/models/remote/requests/get_page/get_page_request.dart';
import '../../../domain/models/remote/responses/get_page/get_page_response.dart';
import '../../../domain/repositories/remote/get_info_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../domain/repositories/database/database_repository.dart';
import '../../../domain/models/local/remember_me_user.dart';
import '../../../domain/repositories/remote/login_repository.dart';
import '../../../domain/models/remote/requests/login/login_request.dart';
import '../../../domain/models/remote/responses/login/login_response.dart';
import '../../../utils/resources/data_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseRepository loginRepository;
  final LoginRepository remoteLoginRepository;
  final GetInfoRepository getInfoRepository;
  final SharedPreferences prefs;

  LoginBloc(this.loginRepository, this.remoteLoginRepository, this.prefs,
      this.getInfoRepository)
      : super(LoginStateInitial()) {
    on<LoginEventLogin>((event, emit) async {
      LoginRequest request =
          LoginRequest(email: event.username, password: event.password);

      emit(LoginStateAttemptLogin());
      bool result = await InternetConnectionChecker().hasConnection;
      if(result == true) {
        DataState<LoginResponse> response =
        await remoteLoginRepository.login(request: request);
        if (response is DataSuccess) {
          if (event.remembermeValue) {
            RememberMeUser user = RememberMeUser(
                username: event.username, password: event.password, id: 1);
            loginRepository.insertRememberedUser(user);
            prefs.setString('token', 'Bearer ${response.data!.token!}');
          } else {
            RememberMeUser user =
            RememberMeUser(username: '', password: '', id: 1);
            loginRepository.deleteRememberedUser(user);
          }

          DataState<GetPageResponse> fetchingFirstPageResponse = await getInfoRepository.getPage(
              request: GetPageRequest(
                  pageNumber: 1, token: prefs.getString("token")));

          if (fetchingFirstPageResponse is DataSuccess) {
            await loginRepository.insertTasks(
              fetchingFirstPageResponse.data!.data!
                  .map((e) => Task(
                  id: e.id,
                  email: e.email!,
                  firstName: e.first_name!,
                  lastName: e.last_name!,
                  avatar: e.avatar!))
                  .toList(),
            );
            emit(LoginStateLoginSuccess());
          } else {
            emit(LoginStateLoginFailure());
          }

        } else {
          emit(LoginStateLoginFailure());
        }
      } else {
        emit(LoginStateLoginFailure());
      }



    });
    on<LoginGetRememberedUser>((event, emit) async {
      RememberMeUser? user = await loginRepository.getRememberedUser();
      if (user == null) {
        emit(LoginStateGetRemembered(username: '', password: ''));
      } else {
        emit(LoginStateGetRemembered(
            username: user.username, password: user.password));
      }
    });
    on<LoginEmitInitial>((event, emit) async {
      emit(LoginStateInitial());
    });
    on<LoginSetState>((event, emit) async {
      if (event.state is! SetStateFirst) {
        emit(SetStateFirst());
      } else {
        emit(SetStateSecond());
      }
    });
  }
}
