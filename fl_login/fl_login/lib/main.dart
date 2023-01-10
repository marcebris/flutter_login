import 'package:fl_login/screens/cambiar_password.dart';
import 'package:fl_login/screens/reset_password.dart';
import 'package:fl_login/services/auth_service.dart';
import 'package:fl_login/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:fl_login/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService() )
        ],
        child: const MyApp()
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
       routes: {
        'login': (_) => const LoginScreen(),
        'home': ( _ ) => const HomeScreen(),
        'reset' : ( _ ) => const ResetPasswordScreen(),
        'cambiar': ( _ ) => const CambiarPasswordScreen()
       },
       theme: AppTheme.ligthTheme
    );
  }
}