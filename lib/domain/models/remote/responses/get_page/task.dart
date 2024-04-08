import 'package:equatable/equatable.dart';

class TaskResponse extends Equatable {
  final int? id;
  final String? email;
  final String? first_name;
  final String? last_name;
  final String? avatar;

  TaskResponse({
    this.id,
    this.email,
    this.first_name,
    this.last_name,
    this.avatar,
  });

  factory TaskResponse.fromMap(Map<String, dynamic> map) {
    return TaskResponse(
      id:map['id'] != null ? map['id'] as int : null,
      email:map['email'] != null ? map['email'] as String : null,
      first_name:map['first_name'] != null ? map['first_name'] as String : null,
      last_name:map['last_name'] != null ? map['last_name'] as String : null,
      avatar:map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': first_name,
    'last_name': last_name,
    'avatar': avatar,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, first_name, last_name, avatar];
}
