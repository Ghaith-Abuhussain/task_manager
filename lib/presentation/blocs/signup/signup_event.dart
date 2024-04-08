import 'package:equatable/equatable.dart';
import './signup_state.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequestSmsAuth extends SignUpEvent {
  final String phoneNumber;

  const SignUpRequestSmsAuth({required this.phoneNumber});
}

class SignUpVerifyPhoneNumber extends SignUpEvent {
  final String otp;

  const SignUpVerifyPhoneNumber({required this.otp});
}

class SignUpEventSignUp extends SignUpEvent {
  final String name;
  final String surname;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String city;
  final String address;
  final String username;
  final String email;
  final String password;

  const SignUpEventSignUp({
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.city,
    required this.address,
    required this.username,
    required this.email,
    required this.password,
  });
}

class SignUpSetState extends SignUpEvent {
  final SignUpState state;

  const SignUpSetState(this.state);
}
