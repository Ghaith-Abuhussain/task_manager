
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpStateInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpStatePhoneVerificationRequested extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpStatePhoneVerificationDone extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpStatePhoneVerificationError extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpStateWaitingForSignUp extends SignUpState {
  @override
  List<Object> get props => [];
}


class SignUpStateSignUpFailure extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpStateSignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}

class SetStateFirst extends SignUpState {
  @override
  List<Object> get props => [];
}

class SetStateSecond extends SignUpState {
  @override
  List<Object> get props => [];
}
