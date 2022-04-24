part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable{}

class LoginInit extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginLoading extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState{
  String? verificationId ;

  LoginSuccess(this.verificationId);

  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState{
  String? error;

  LoginError(this.error);

  @override
  List<Object?> get props => [];
}

class LoginDecide extends LoginState{
  final DecideResponse? response ;

  LoginDecide(this.response);

  @override
  List<Object?> get props => [];
}

class LoginDecideError extends LoginState{
  @override
  List<Object?> get props => [];
}


