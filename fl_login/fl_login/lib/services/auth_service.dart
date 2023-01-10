import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/models.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'api.monee.cl';

  Future<LoginResponse> validateUser(String username, String password) async {
    final Map<String, dynamic> authData = {
      'Username': username,
      'Password': password
    };

    final url = Uri.http(_baseUrl, 'Login/ValidaLogin');

    final respuesta = await http.post(url, body: authData);

    var algo = LoginResponse.fromJson(respuesta.body);

    return algo;
  }


  Future<ResetPassResponse> resetPassword(String email) async{
     final Map<String, dynamic> request = {
      'Email': email
    };

    final url = Uri.http(_baseUrl, 'Login/RecuperarPassword');

     final respuesta = await http.post(url, body: request);

     return ResetPassResponse.fromJson(respuesta.body);
  }
}
