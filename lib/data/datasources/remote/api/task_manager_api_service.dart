import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_managing/domain/models/remote/requests/add_task/add_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/edit_task/edit_task_request_body.dart';
import 'package:task_managing/domain/models/remote/requests/get_page/get_page_request.dart';
import 'package:task_managing/domain/models/remote/responses/add_task/add_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/delete_task/delete_task_response.dart';
import 'package:task_managing/domain/models/remote/responses/get_page/get_page_response.dart';
import '../../../../domain/models/remote/requests/edit_task/edit_task_request.dart';
import '../../../../domain/models/remote/requests/signup/sign_up_request.dart';
import '../../../../domain/models/remote/responses/edit_task/edit_task_response.dart';
import '../../../../domain/models/remote/responses/signup/sign_up_response.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../domain/models/remote/requests/login/login_request.dart';
import '../../../../domain/models/remote/responses/login/login_response.dart';

part 'task_manager_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable) // must put baseUrl
abstract class TaskManagerApiService {
  factory TaskManagerApiService(Dio dio, {String baseUrl}) =
      _TaskManagerApiService;

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @POST('/api/register')
  Future<HttpResponse<SignUpResponse>> signUp({
    @Body() SignUpRequest? body,
  });

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @POST('/api/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() LoginRequest? body,
  });

  @GET('/api/users?page={id}')
  Future<HttpResponse<GetPageResponse>> getPage(
      @Header("Authorization") String token, @Path() String id);

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @PUT('/api/users/{id}')
  Future<HttpResponse<EditTaskResponse>> editTask({
    @Header("Authorization") String? token,
    @Path() String? id,
    @Body() EditTaskRequestBody? body,
  });

  @DELETE('/api/users/{id}')
  Future<HttpResponse<String?>> deleteTask(
      @Header("Authorization") String token, @Path() String id);

  @Headers(<String, dynamic>{
    //Static header
    "Content-Type": "application/json",
  })
  @POST('/api/users')
  Future<HttpResponse<AddTaskResponse>> addTask({
    @Header("Authorization") String? token,
    @Body() AddTaskRequestBody? body,
  });
}
