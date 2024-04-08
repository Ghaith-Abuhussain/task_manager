import 'package:equatable/equatable.dart';

class EditTaskResponse extends Equatable {
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? updatedAt;
  EditTaskResponse({this.first_name, this.last_name, this.email, this.updatedAt});
  factory EditTaskResponse.fromMap(Map<String, dynamic> map) {
    return EditTaskResponse(
      first_name: map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [first_name, last_name, email, updatedAt];

}