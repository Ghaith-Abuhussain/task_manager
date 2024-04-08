import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? token;

  LoginResponse({this.token});
  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [token];

}