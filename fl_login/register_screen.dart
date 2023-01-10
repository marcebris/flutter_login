import 'package:fl_login/providers/login_form_provider.dart';
import 'package:fl_login/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
            Text('Crea una cuenta', style: Theme.of(context).textTheme.headline4),
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
        Navigator.pushReplacementNamed(context, 'login'), 
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(AppTheme.primary)
        ),
       child:  const Text(
          'Volver al login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: AppTheme.primary),
        )
       )
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
    //final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {'username': '', 'password': ''};
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            CustomInputField(
                labelText: 'Usuario',
                icon: Icons.person_outline,
                hintText: 'Usuario',
                formProperty: 'username',
                formValues: formValues),
            const SizedBox(height: 30),
            CustomInputField(
                labelText: 'Password',
                obscureText: true,
                icon: Icons.password,
                hintText: 'Password',
                formProperty: 'password',
                formValues: formValues),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: loginForm.isLoading ? null : () async {
                  FocusScope.of(context).unfocus();
                  if (!loginForm.isValidForm()) return;

                    loginForm.username = formValues['username'] ?? "";
                    loginForm.password = formValues['password'] ?? "";
                  
                  loginForm.isLoading = true;

                  await Future.delayed(const Duration(seconds: 2));

                  loginForm.isLoading = false;

                  Navigator.pushReplacementNamed(context, 'home');

                },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: 
                    Text(
                      loginForm.isLoading
                      ? 'Espere...' 
                      : 'Ingresar'
                    )),
                ))
          ],
        ));
  }
}
