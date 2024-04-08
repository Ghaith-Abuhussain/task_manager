
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing/domain/models/local/task.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/delete_task/delete_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/edit_task/edit_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/get_page/get_page_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_task/add_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/edit_task/edit_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/get_page_response.dart';
import 'package:task_managing/presentation/blocs/home/home_event.dart';
import 'package:task_managing/presentation/blocs/home/home_state.dart';

import '../../../domain/models/remote/requests/edit_task/edit_task_request.dart';
import '../../../domain/repositories/database/database_repository.dart';
import '../../../domain/repositories/remote/get_info_repository.dart';
import '../../../utils/resources/data_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseRepository databaseRepository;
  final GetInfoRepository getInfoRepository;
  final SharedPreferences prefs;

  int newPage = 1;

  HomeBloc(this.databaseRepository, this.prefs, this.getInfoRepository)
      : super(HomeStateInitial()) {
    on<HomeEventDisplayData>((event, emit) async {
      emit(HomeStateDisplayData(await databaseRepository.getAllTasks()));
    });
    on<HomeEventGetPage>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateGettingPageData(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<GetPageResponse> response = await getInfoRepository.getPage(
            request: GetPageRequest(
                pageNumber: event.pageNumber, token: prefs.getString("token")));

        if (response is DataSuccess) {
          newPage = 1;
          await databaseRepository.deleteAllTasks();
          await databaseRepository.insertTasks(
            response.data!.data!
                .map((e) => Task(
                    id: e.id,
                    email: e.email!,
                    firstName: e.first_name!,
                    lastName: e.last_name!,
                    avatar: e.avatar!))
                .toList(),
          );

          tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingPageDataSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingPageDataFailure(tasks));
        }
      } else {
        emit(FinishGettingPageDataFailure(tasks));
      }
    });
    on<HomeEventGetNewPage>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateGettingNewPageData(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<GetPageResponse> response = await getInfoRepository.getPage(
            request: GetPageRequest(
                pageNumber: newPage + 1, token: prefs.getString("token")));

        if (response is DataSuccess) {
          if (response.data!.data!.isNotEmpty) {
            newPage = newPage + 1;
          } else {
            emit(NoMoreDataToFitch(tasks));
          }

          await databaseRepository.insertTasks(
            response.data!.data!
                .map((e) => Task(
                    id: e.id,
                    email: e.email!,
                    firstName: e.first_name!,
                    lastName: e.last_name!,
                    avatar: e.avatar!))
                .toList(),
          );

          tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingNewPageDataSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(FinishGettingNewPageDataFailure(tasks));
        }
      } else {
        emit(FinishGettingNewPageDataFailure(tasks));
      }
    });
    on<HomeEventEditTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateEditingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<EditTaskResponse> response = await getInfoRepository.editTask(
          request: EditTaskRequest(
            id: event.taskNumber,
            token: prefs.getString("token"),
            body: EditTaskRequestBody(
              firstName: event.firstName,
              lastName: event.lastName,
              email: event.email,
            ),
          ),
        );

        if (response is DataSuccess) {
          Task? task = await databaseRepository.getTask(event.taskNumber);

          await databaseRepository.insertTask(Task(
            id: task!.id,
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: task.avatar,
          ));

          tasks = await databaseRepository.getAllTasks();
          emit(HomeStateEditingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateEditingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateEditingTaskFailure(tasks));
      }
    });
    on<HomeEventDeletingTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateDeletingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<String?> response = await getInfoRepository.deleteTask(
          request: DeleteTaskRequest(
            taskNumber: event.taskNumber,
            token: prefs.getString("token"),
          ),
        );

        if (response is DataSuccess) {
          await databaseRepository.deleteTaskOnId(event.taskNumber);
          tasks = await databaseRepository.getAllTasks();
          emit(HomeStateDeletingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateDeletingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateDeletingTaskFailure(tasks));
      }
    });
    on<HomeEventAddingTask>((event, emit) async {
      var tasks = await databaseRepository.getAllTasks();
      emit(HomeStateAddingTask(tasks));

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        DataState<AddTaskResponse> response = await getInfoRepository.addTask(
          request: AddTaskRequest(
            token: prefs.getString("token"),
            body: AddTaskRequestBody(
              firstName: event.firstName,
              lastName: event.lastName,
              email: event.email,
              avatar: event.avatar,
            ),
          ),
        );

        if (response is DataSuccess) {
          await databaseRepository.insertTask(
            Task(
              id: int.parse(response.data!.id!),
              firstName: response.data!.first_name!,
              lastName: response.data!.last_name!,
              avatar: response.data!.avatar!,
              email: response.data!.email!,
            ),
          );

          tasks = await databaseRepository.getAllTasks();
          emit(HomeStateAddingTaskSuccess(tasks));
        } else {
          var tasks = await databaseRepository.getAllTasks();
          emit(HomeStateAddingTaskFailure(tasks));
        }
      } else {
        emit(HomeStateAddingTaskFailure(tasks));
      }
    });
  }
}
