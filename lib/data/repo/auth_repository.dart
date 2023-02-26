import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:nikestore/common/http_client.dart';
import 'package:nikestore/data/autinfo.dart';
import 'package:nikestore/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> logIn(String userName, String passWord);
  Future<void> singUp(String userName, String passWord);
  Future<void> refreshToken();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifire =
      ValueNotifier(null);
  final IAuthDataSource authDataSource;

  AuthRepository(this.authDataSource);
  @override
  Future<void> logIn(String userName, String passWord) async {
    //کد
    final AuthInfo authInfo = await authDataSource.logIn(userName, passWord);
    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> singUp(String userName, String passWord) async {
    final AuthInfo authInfo = await authDataSource.singUp(userName, passWord);
    _persistAuthTokens(authInfo);
  }

  @override
  Future<void> refreshToken() async {
    if(authChangeNotifire.value!=null){
      final AuthInfo authInfo = await authDataSource
        .refreshToken(authChangeNotifire.value!.refreshToken);
    _persistAuthTokens(authInfo);
    }
    
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifire.value = AuthInfo(accessToken, refreshToken);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifire.value = null;
  }
}
