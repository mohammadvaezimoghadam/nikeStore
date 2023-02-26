part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent{

}

class AuthBtnIsClicked extends AuthEvent{
  final  String userName;
  final String passWord;

  const AuthBtnIsClicked(this.userName, this.passWord);

  @override
  // TODO: implement props
  List<Object> get props => [userName,passWord];

}

class AuthModeChangeIsClick extends AuthEvent{

}


