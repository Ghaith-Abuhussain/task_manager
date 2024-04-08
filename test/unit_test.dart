import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:task_managing/domain/models/local/remember_me_user.dart';
import 'package:task_managing/domain/models/local/task.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/delete_task/delete_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/edit_task/edit_task_request.dart';
import 'package:task_managing/domain/models/remote/requests/edit_task/edit_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/get_page/get_page_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_task/add_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/edit_task/edit_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/get_page_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/support.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/task.dart';
import 'package:task_managing/domain/repositories/database/database_repository.dart';
import 'package:task_managing/domain/repositories/remote/get_info_repository.dart';
import 'package:task_managing/utils/resources/data_state.dart';

List<Task> tasksEndpoint = [
  Task(
    id: 1,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  ),
  Task(
    id: 2,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  ),
  Task(
    id: 3,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  ),
  Task(
    id: 4,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  ),
  Task(
    id: 5,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  ),
  Task(
    id: 6,
    email: "gaes.abu@gmail.com",
    firstName: "Ghaith",
    lastName: "AbuHussain",
    avatar: "aaaaaaa",
  )
];

List<Task> tasksDataBase = [];

bool connection = true;

class MockDatabaseRepository extends Mock implements DatabaseRepository {
  @override
  Future<List<Task>> getAllTasks() async {
    return tasksDataBase;
  }

  @override
  Future<void> insertTasks(List<Task> taskList) async {
    taskList.forEach((element) {
      tasksDataBase.add(element);
    });
  }

  @override
  Future<void> deleteAllTasks() async {
    tasksDataBase = [];
  }

  @override
  Future<void> insertTask(Task task) async {
    try {

      Task element =
          tasksDataBase.firstWhere((element) => element.id == task.id);
      tasksDataBase[tasksDataBase.indexOf(element)] = task;
    } on StateError catch (e) {
      tasksDataBase.add(task);
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    tasksDataBase.removeWhere((element) => element.id == task.id);
  }

  @override
  Future<Task?> getTask(int id) async {
    return tasksDataBase.firstWhere((element) => element.id == id);
  }

  @override
  Future<void> deleteTaskOnId(int id) async {
    tasksDataBase.removeWhere((element) => element.id == id);
  }
}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {
  @override
  // TODO: implement hasConnection
  Future<bool> get hasConnection => Future(() => connection);
}

class MockGetInfoRepository extends Mock implements GetInfoRepository {
  @override
  Future<DataState<GetPageResponse>> getPage({
    required GetPageRequest request,
  }) async {
    if (request.token == "right") {
      return Future(
        () => DataSuccess(
          GetPageResponse(
              support: SupportResponse(text: "asdasdasd", url: "asdasdasd"),
              data: tasksEndpoint
                  .map((e) => TaskResponse(
                      id: e.id,
                      email: e.email,
                      avatar: e.avatar,
                      first_name: e.firstName,
                      last_name: e.lastName))
                  .toList(),
              page: 1,
              per_page: 6,
              total: 12,
              total_pages: 2),
        ),
      );
    } else {
      return Future(
        () => DataFailed(
          DioException(requestOptions: RequestOptions(data: "xxxx")),
        ),
      );
    }
  }

  @override
  Future<DataState<EditTaskResponse>> editTask(
      {required EditTaskRequest request}) async {
    if (request.token == "right") {
      return Future(
        () => DataSuccess(
          EditTaskResponse(
              first_name: request.body!.firstName,
              last_name: request.body!.lastName,
              email: request.body!.email,
              updatedAt: "2024-08-04"),
        ),
      );
    } else {
      return Future(
        () => DataFailed(
          DioException(requestOptions: RequestOptions(data: "xxxx")),
        ),
      );
    }
  }

  @override
  Future<DataState<String?>> deleteTask(
      {required DeleteTaskRequest request}) async {
    if (request.token == "right") {
      return Future(
        () => DataSuccess(""),
      );
    } else {
      return Future(
        () => DataFailed(
          DioException(requestOptions: RequestOptions(data: "xxxx")),
        ),
      );
    }
  }

  @override
  Future<DataState<AddTaskResponse>> addTask(
      {required AddTaskRequest request}) async {
    if (request.token == "right") {
      return Future(
        () => DataSuccess(
          AddTaskResponse(
              id: "192",
              avatar: "aaaaaaaa",
              first_name: "Ghaith",
              last_name: "Abu Hussain",
              email: "gaes.abu2016@gmail.com",
              createdAt: "2024-08-04"),
        ),
      );
    } else {
      return Future(
        () => DataFailed(
          DioException(requestOptions: RequestOptions(data: "xxxx")),
        ),
      );
    }
  }
}

void main() {
  MockDatabaseRepository mockDatabaseRepository = MockDatabaseRepository();
  MockGetInfoRepository mockGetInfoRepository = MockGetInfoRepository();

  test("Fetch Data With Internet Connection", () async {
    connection = true;
    var token = "right";

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<GetPageResponse> response = await mockGetInfoRepository.getPage(
        request: GetPageRequest(token: token, pageNumber: 2),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteAllTasks();
        await mockDatabaseRepository.insertTasks(response.data!.data!
            .map((e) => Task(
                id: e.id,
                email: e.email!,
                firstName: e.first_name!,
                lastName: e.last_name!,
                avatar: e.avatar!))
            .toList());
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Fetch Data With No Internet Connection", () async {
    connection = false;
    var token = "right";

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<GetPageResponse> response = await mockGetInfoRepository.getPage(
        request: GetPageRequest(token: "right", pageNumber: 2),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteAllTasks();
        await mockDatabaseRepository.insertTasks(response.data!.data!
            .map((e) => Task(
                id: e.id,
                email: e.email!,
                firstName: e.first_name!,
                lastName: e.last_name!,
                avatar: e.avatar!))
            .toList());
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Fetch Data With Error Fetching Data from Endpoint", () async {
    connection = true;
    var token = "false";

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<GetPageResponse> response = await mockGetInfoRepository.getPage(
        request: GetPageRequest(token: "right", pageNumber: 2),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteAllTasks();
        await mockDatabaseRepository.insertTasks(response.data!.data!
            .map((e) => Task(
                id: e.id,
                email: e.email!,
                firstName: e.first_name!,
                lastName: e.last_name!,
                avatar: e.avatar!))
            .toList());
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Edit Task With Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "right";
    int taskId = 2;
    EditTaskRequestBody editTaskRequestBody = EditTaskRequestBody(
        email: "test@gmail.com", firstName: "test", lastName: "edit");

    var newTasks = await mockDatabaseRepository.getAllTasks();
    Task compareTask = Task(
      id: taskId,
      email: "test@gmail.com",
      firstName: "test",
      lastName: "edit",
      avatar: "",
    );
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<EditTaskResponse> response =
          await mockGetInfoRepository.editTask(
        request: EditTaskRequest(
            token: token, id: taskId, body: editTaskRequestBody),
      );
      if (response is DataSuccess) {
        var newTask = await mockDatabaseRepository.getTask(taskId);
        print(response.data);
        await mockDatabaseRepository.insertTask(
          Task(
            id: newTask!.id,
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: newTask.avatar,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
        compareTask = Task(
          id: newTask!.id,
          email: "test@gmail.com",
          firstName: "test",
          lastName: "edit",
          avatar: newTask.avatar,
        );
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }

    expectLater(
        newTasks.firstWhere((element) => element.id == taskId), compareTask);
    return;
  });

  test("Edit Task With No Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = false;
    var token = "right";
    int taskId = 2;
    EditTaskRequestBody editTaskRequestBody = EditTaskRequestBody(
        email: "test@gmail.com", firstName: "test", lastName: "edit");

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<EditTaskResponse> response =
          await mockGetInfoRepository.editTask(
        request: EditTaskRequest(
            token: token, id: taskId, body: editTaskRequestBody),
      );
      if (response is DataSuccess) {
        var newTask = await mockDatabaseRepository.getTask(taskId);
        await mockDatabaseRepository.insertTask(
          Task(
            id: newTask!.id,
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: newTask.avatar,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Edit Task With Error Fetching Data from Endpoint", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "false";
    int taskId = 2;
    EditTaskRequestBody editTaskRequestBody = EditTaskRequestBody(
        email: "test@gmail.com", firstName: "test", lastName: "edit");

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<EditTaskResponse> response =
          await mockGetInfoRepository.editTask(
        request: EditTaskRequest(
            token: token, id: taskId, body: editTaskRequestBody),
      );
      if (response is DataSuccess) {
        var newTask = await mockDatabaseRepository.getTask(taskId);
        await mockDatabaseRepository.insertTask(
          Task(
            id: newTask!.id,
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: newTask.avatar,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksDataBase);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Delete Task With Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "right";
    int taskId = 2;

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<String?> response = await mockGetInfoRepository.deleteTask(
        request: DeleteTaskRequest(token: token, taskNumber: taskId),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteTaskOnId(taskId);
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.removeWhere((element) => element.id == taskId);
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Delete Task With No Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = false;
    var token = "right";
    int taskId = 2;

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<String?> response = await mockGetInfoRepository.deleteTask(
        request: DeleteTaskRequest(token: token, taskNumber: taskId),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteTaskOnId(taskId);
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.removeWhere((element) => element.id == taskId);
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Delete Task With Error Fetching Data from Endpoint", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "false";
    int taskId = 2;

    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<String?> response = await mockGetInfoRepository.deleteTask(
        request: DeleteTaskRequest(token: token, taskNumber: taskId),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.deleteTaskOnId(taskId);
        newTasks = await mockDatabaseRepository.getAllTasks();
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.removeWhere((element) => element.id == taskId);
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Add Task With Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "right";
    int newTaskId = 2;
    AddTaskRequestBody addTaskRequestBody = AddTaskRequestBody(
        firstName: "Mohammad",
        lastName: "AlAhmad",
        email: "mohammed@gmail.com",
        avatar: "mohammmeeeeed");

    Task addedTask = Task(
      id: 0,
      email: "test@gmail.com",
      firstName: "test",
      lastName: "edit",
      avatar: "",
    );
    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<AddTaskResponse> response = await mockGetInfoRepository.addTask(
        request: AddTaskRequest(token: token, body: addTaskRequestBody),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.insertTask(
          Task(
            id: int.parse(response.data!.id!),
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: response.data!.avatar!,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
        addedTask = Task(
          id: int.parse(response.data!.id!),
          email: response.data!.email!,
          firstName: response.data!.first_name!,
          lastName: response.data!.last_name!,
          avatar: response.data!.avatar!,
        );
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.add(addedTask);
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Add Task With No Internet Connection", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = false;
    var token = "right";
    int newTaskId = 2;
    AddTaskRequestBody addTaskRequestBody = AddTaskRequestBody(
        firstName: "Mohammad",
        lastName: "AlAhmad",
        email: "mohammed@gmail.com",
        avatar: "mohammmeeeeed");

    Task addedTask = Task(
      id: 0,
      email: "test@gmail.com",
      firstName: "test",
      lastName: "edit",
      avatar: "",
    );
    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<AddTaskResponse> response = await mockGetInfoRepository.addTask(
        request: AddTaskRequest(token: token, body: addTaskRequestBody),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.insertTask(
          Task(
            id: int.parse(response.data!.id!),
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: response.data!.avatar!,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
        addedTask = Task(
          id: int.parse(response.data!.id!),
          email: response.data!.email!,
          firstName: response.data!.first_name!,
          lastName: response.data!.last_name!,
          avatar: response.data!.avatar!,
        );
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.add(addedTask);
    expectLater(newTasks, tasksEndpoint);
    return;
  });

  test("Add Task With Error Fetching Data from Endpoint", () async {
    tasksDataBase = List.from(tasksEndpoint);
    connection = true;
    var token = "false";
    int newTaskId = 2;
    AddTaskRequestBody addTaskRequestBody = AddTaskRequestBody(
        firstName: "Mohammad",
        lastName: "AlAhmad",
        email: "mohammed@gmail.com",
        avatar: "mohammmeeeeed");

    Task addedTask = Task(
      id: 0,
      email: "test@gmail.com",
      firstName: "test",
      lastName: "edit",
      avatar: "",
    );
    var newTasks = await mockDatabaseRepository.getAllTasks();
    if (await MockInternetConnectionChecker().hasConnection) {
      DataState<AddTaskResponse> response = await mockGetInfoRepository.addTask(
        request: AddTaskRequest(token: token, body: addTaskRequestBody),
      );
      if (response is DataSuccess) {
        await mockDatabaseRepository.insertTask(
          Task(
            id: int.parse(response.data!.id!),
            email: response.data!.email!,
            firstName: response.data!.first_name!,
            lastName: response.data!.last_name!,
            avatar: response.data!.avatar!,
          ),
        );
        newTasks = await mockDatabaseRepository.getAllTasks();
        addedTask = Task(
          id: int.parse(response.data!.id!),
          email: response.data!.email!,
          firstName: response.data!.first_name!,
          lastName: response.data!.last_name!,
          avatar: response.data!.avatar!,
        );
      } else {
        expectLater(newTasks, tasksEndpoint);
        return;
      }
    } else {
      expectLater(newTasks, tasksDataBase);
      return;
    }
    tasksEndpoint.add(addedTask);
    expectLater(newTasks, tasksEndpoint);
    return;
  });


}
