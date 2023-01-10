import 'package:flutter/material.dart';

import 'package:fl_login/services/services.dart';
import 'package:fl_login/themes/app_theme.dart';
import 'package:fl_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../model/models.dart';
import '../providers/providers.dart';
import 'alerts/alerts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 250),
        CardContainer(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Text('Login', style: Theme.of(context).textTheme.headline4),
            const SizedBox(
              height: 30,
            ),
            ChangeNotifierProvider(
              create: (_) => LoginFormProvider(),
              child: const _LoginForm(),
            )
          ]),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppTheme.primary)),
            child: const Text(
              'Crear cuenta',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.primary),
            ))
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginFormProvider loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            _CajaTextoLogin(
              provider: loginForm,
              icono: Icons.person,
              obscureText: false,
              text: 'Usuario',
              tipoCaja: 'user',
            ),
            const SizedBox(height: 30),
            _CajaTextoLogin(
              provider: loginForm,
              icono: Icons.password,
              obscureText: true,
              text: 'Password',
              tipoCaja: 'pass',
            ),
            const SizedBox(height: 5),
            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'reset'),
                child: const Text(
                  '¿Olvidó su contraseña?',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.primary),
                )),
            const SizedBox(height: 5),
            ElevatedButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        loginForm.isLoading = true;
                        final LoginResponse respApi =
                            await authService.validateUser(
                                loginForm.username, loginForm.password);

                        loginForm.isLoading = false;
                        if (respApi.esValido! && !respApi.cambiarClave!) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'home',
                              arguments: respApi);
                        } else {
                          //USUARIO NO ES VALIDO O DEBE CAMBIAR CLAVE
                          if (respApi.cambiarClave!) {
                            // ignore: use_build_context_synchronously
                            displayDialog(
                                context, '', respApi, 'Debe cambiar su clave');
                          }

                          if (!respApi.esValido!) {
                            // ignore: use_build_context_synchronously
                            displayDialog(context, 'error', null,
                                'El usuario y/o contraseña ingresados no son correctos.');
                          }
                        }
                      },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                      child:
                          Text(loginForm.isLoading ? 'Espere...' : 'Ingresar')),
                ))
          ],
        ));
  }

  void displayDialog(BuildContext context, String tipo, arguments, String mensaje) {
    
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertaInfo(
              titulo: tipo == 'error' ? 'Error' : 'Mensaje',
              texto: mensaje,
              child: ElevatedButton(
                onPressed: () {
                  if (tipo == 'error') {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, 'cambiar',
                     arguments: arguments);
                  }
                },
                child: const Text('Aceptar'),
              ));
        });
  }
}

class _CajaTextoLogin extends StatelessWidget {
  const _CajaTextoLogin(
      {Key? key,
      required this.tipoCaja,
      required this.provider,
      required this.icono,
      required this.obscureText,
      required this.text})
      : super(key: key);

  final String tipoCaja;
  final LoginFormProvider provider;
  final IconData icono;
  //final TextInputType keyBoard;
  final String text;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          if (tipoCaja == 'user') {
            provider.username = value;
          } else {
            provider.password = value;
          }
        },
        validator: (value) {
          if (value == null) return 'Este campo es requerido';
          return value.length < 3 ? value : null;
        },
        decoration: InputDecoration(
            hintText: text,
            labelText: text,
            //helperText: 'Ingrese su usuario',
            suffixIcon: Icon(
              icono,
              color: AppTheme.primary,
            )));
  }
}
