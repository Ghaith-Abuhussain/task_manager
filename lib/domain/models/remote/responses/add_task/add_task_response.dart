import 'package:equatable/equatable.dart';

class AddTaskResponse extends Equatable {
  final String? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? avatar;
  final String? createdAt;
  AddTaskResponse({this.id, this.first_name, this.last_name, this.email, this.avatar, this.createdAt});
  factory AddTaskResponse.fromMap(Map<String, dynamic> map) {
    return AddTaskResponse(
      id: map['id'] != null ? map['id'] as String : null,
      first_name: map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [id, first_name, last_name, email, createdAt];

}