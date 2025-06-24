part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginRememberMeChanged extends LoginEvent {
  const LoginRememberMeChanged(this.rememberMe);
  final bool rememberMe;

  @override
  List<Object> get props => [rememberMe];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}