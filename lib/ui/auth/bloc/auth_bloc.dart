import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/repo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;
  bool isLogin;
  AuthBloc(this.repository, {this.isLogin = true})
      : super(AuthInitial(isLogin)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthBtnIsClicked) {
          emit(AuthLoading(isLogin));
          if (isLogin) {
            await repository.logIn(event.userName, event.passWord);
            emit(AuthSuccess(isLogin));
          } else {
            await repository.singUp(event.userName, event.passWord);
            emit(AuthSuccess(isLogin));
          }
        } else if (event is AuthModeChangeIsClick) {
          isLogin = !isLogin;
          emit(AuthInitial(isLogin));
        }
      } catch (e) {
        emit(AuthError(AppException()));
      }
    });
  }
}
