import 'package:fl_login/model/login_respose.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final LoginResponse userLogin = ModalRoute.of(context)!.settings.arguments as LoginResponse;

    return Scaffold(
      body: Center(
         child: Text(userLogin.nombre!),
      ),
    );
  }
}