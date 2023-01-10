import 'package:fl_login/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyBoard;
  final bool obscureText;

  final Map<String, String> formValues;
  final String formProperty;

  const CustomInputField({
    Key? key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.icon, 
    this.suffixIcon, this.keyBoard, 
    this.obscureText = false, 
    required this.formProperty, 
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      initialValue: '',
      //textCapitalization: TextCapitalization.words,
      keyboardType: keyBoard,
      obscureText: obscureText,
      onChanged: (value){
          formValues[formProperty] = value;
      } ,
       validator: (value) {
        //if (value == null) return 'Este campo es requerido';
        if(value == null || value.isEmpty) return 'Este campo es requerido';
        //return value.length < 3 ? value : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        suffixIcon: Icon(icon, color: AppTheme.primary,),
        //prefixIcon: Icon(Icons.verified),
        icon: suffixIcon == null ? null : Icon(suffixIcon, color: AppTheme.primary),
         border: const OutlineInputBorder(
           borderRadius: BorderRadius.only(
             bottomLeft: Radius.circular(10),
             topRight: Radius.circular(10)
           )
         )
      ),
    );
  }
}
