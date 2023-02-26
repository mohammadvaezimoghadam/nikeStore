import 'package:dio/dio.dart';
import 'package:nikestore/common/constans.dart';
import 'package:nikestore/common/http_response_validator.dart';
import 'package:nikestore/data/autinfo.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> logIn(String userName, String passWord);
  Future<AuthInfo> singUp(String userName, String passWord);
  Future<AuthInfo> refreshToken(String token);
}

class AuthDataSource with HttpResponseValidator implements IAuthDataSource {
  final Dio httpClient;

  AuthDataSource(this.httpClient);
  @override
  Future<AuthInfo> logIn(String userName, String passWord) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constsns.clientSecret,
      "username": userName,
      "password": passWord,
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client+id": 2,
      "client_secret": Constsns.clientSecret,
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> singUp(String userName, String passWord) async {
    final response = await httpClient.post("user/register", data: {
      "email": userName,
      "password": passWord,
    });
    validateResponse(response);
    return logIn(userName, passWord);
  }
}
