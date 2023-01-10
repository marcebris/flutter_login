import 'package:flutter/material.dart';

import 'package:fl_login/services/services.dart';
import 'package:fl_login/themes/app_theme.dart';
import 'package:fl_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../model/models.dart';
import '../providers/providers.dart';
import 'alerts/alerts.dart';

class CambiarPasswordScreen extends StatelessWidget {
  const CambiarPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final LoginResponse userLogin = ModalRoute.of(context)!.settings.arguments as LoginResponse;

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
            Text(userLogin.nombre!, style: Theme.of(context).textTheme.headline4),
            const SizedBox(
              height: 30,
            ),
            ChangeNotifierProvider(
                create: (_) => CambiarPassProvider(),
                child: const _CambiarPasswordForm())
          ]),
        ),
        const SizedBox(
          height: 50,
        )
      ]),
    )));
  }
}

class _CambiarPasswordForm extends StatelessWidget {
  const _CambiarPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CambiarPassProvider loginForm = Provider.of<CambiarPassProvider>(context);

    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  loginForm.clave = value;
                },
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.length < 3 ? value : null;
                },
                decoration: const InputDecoration(
                    hintText: 'Nueva clave',
                    labelText: 'Nueva clave',
                    suffixIcon: Icon(
                      Icons.password,
                      color: AppTheme.primary,
                    ))),
            const SizedBox(height: 30),
            TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                 // loginForm.email = value;
                },
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.length < 3 ? value : null;
                },
                decoration: const InputDecoration(
                    hintText: 'Repita clave',
                    labelText: 'Repita clave',
                    suffixIcon: Icon(
                      Icons.password,
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
                            await authService.resetPassword(loginForm.clave);
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
                          loginForm.isLoading ? 'Espere...' : 'Cambiar')),
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
              texto:
                  'Se ha enviado un correo con su nueva contraseña al email ingresado.',
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Text('Volver al login'),
              ));
        });
  }
}
