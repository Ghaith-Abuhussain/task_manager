import 'package:equatable/equatable.dart';
class SignUpResponse extends Equatable {
  final int? id;
  final String? token;

  const SignUpResponse({
    this.id,
    this.token,
  });

  factory SignUpResponse.fromMap(Map<String, dynamic> map) {
    return SignUpResponse(
      id: map['id'] != null ? map['id'] as int : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        token,
      ];
}
