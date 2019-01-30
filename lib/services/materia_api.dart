import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import '../models/materia/account.dart';
import '../models/materia/token.dart';
import '../models/materia/user.dart';
import '../models/materia/tmp_token.dart';
import '../models/materia/password_reset_token.dart';
import './base_api.dart';

// no auth
Future<Token> signIn(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'sign-in');
  final http.Response response = await post(path, data);
  return Token.fromJson(json.decode(response.body));
}

Future<Token> refresh(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'refresh');
  final http.Response response = await post(path, data);
  return Token.fromJson(json.decode(response.body));
}

Future<TmpToken> tmpRegistration(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'tmp-registration');
  final http.Response response = await post(path, data);
  return TmpToken.fromJson(json.decode(response.body));
}

Future<PasswordResetToken> requestPasswordReset(String basePath, Map<String, dynamic> data) async {
  final String path = p.join(basePath, 'request-password-reset');
  final http.Response response = await post(path, data);
  return PasswordResetToken.fromJson(json.decode(response.body));
}

// tmp_user_auth
Future<Map<String, dynamic>> validationTmpUser(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'validation-tmp-user');
  final http.Response response = await get(path, token: token);
  return json.decode(response.body);
}


Future<User> userRegistration(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'user-registration');
  final http.Response response = await post(path, data, token: token);
  return User.fromJson(json.decode(response.body));
}

Future<Map<String, dynamic>> userRegistrationAndSignIn(String basePath, Map<String, dynamic> data, String token) async {
  final String path = p.join(basePath, 'user-registration-and-sign-in');
  final http.Response response = await post(path, data, token: token);
  return json.decode(response.body);
}

//// pw_reset_auth
//Future<User> varidationPwReset(String basePath, Map<String, dynamic> data) async {
//  final String path = p.join(basePath, 'varidation-pw-reset');
//  final http.Response response = await get(path);
//  return User.fromJson(json.decode(response.body));
//}
//
//Future<User> resetMyPassword(String basePath, Map<String, dynamic> data) async {
//  final String path = p.join(basePath, 'reset-my-password');
//  final http.Response response = await post(path, data);
//  return User.fromJson(json.decode(response.body));
//}