part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.isLogin);
  final bool isLogin;

  @override
  List<Object> get props => [isLogin];
}

class AuthInitial extends AuthState {
  AuthInitial(bool isLogin) : super(isLogin);
  @override
  // TODO: implement props
  List<Object> get props => [isLogin];
}

class AuthLoading extends AuthState {
  AuthLoading(bool isLogin) : super(isLogin);
}

class AuthSuccess extends AuthState {
  AuthSuccess(bool isLogin) : super(isLogin);
}

class AuthError extends AuthState {
  final AppException exception;

  AuthError(this.exception) : super(false);
  
  
  
}
