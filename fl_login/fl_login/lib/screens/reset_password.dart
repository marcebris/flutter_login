import 'package:flutter/material.dart';

import 'package:fl_login/services/services.dart';
import 'package:fl_login/themes/app_theme.dart';
import 'package:fl_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../model/models.dart';
import '../providers/providers.dart';
import 'alerts/alerts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
            Text('Recuperar clave',
                style: Theme.of(context).textTheme.headline4),
            const SizedBox(
              height: 30,
            ),
            ChangeNotifierProvider(
                create: (_) => ResetPassProvider(),
                child: const _ResetPasswordForm())
          ]),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppTheme.primary)),
            child: const Text(
              'Volver al login',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.primary),
            ))
      ]),
    )));
  }
}

class _ResetPasswordForm extends StatelessWidget {
  const _ResetPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPassProvider loginForm = Provider.of<ResetPassProvider>(context);

    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  loginForm.email = value;
                },
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Correo no válido';
                },
                decoration: const InputDecoration(
                    hintText: 'Correo electrónico',
                    labelText: 'Correo electrónico',
                    suffixIcon: Icon(
                      Icons.email,
                      color: AppTheme.primary,
                    ))),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        final ResetPassResponse respApi =
                            await authService.resetPassword(loginForm.email);
                        if (respApi.header!.code != '00') {
                          //Ha ocurrido un error inesperado
                        } else {
                          if (!respApi.resultado) {
                            //EL correo ingresado no existe
                          } else {
                            //CORRECTO
                            //Mostrar mensaje de que se envió un correo a la dirección x
                            displayDialog(context);
                          }
                        }
                      },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                          loginForm.isLoading ? 'Espere...' : 'Recuperar')),
                ))
          ],
        ));
  }

  void displayDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertaInfo(
            titulo: 'Recuperar contraseña',
            texto: 'Se ha enviado un correo con su nueva contraseña al email ingresado.',
            child: ElevatedButton(
              onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text('Volver al login'),
            )
          );
        });
  }
}

