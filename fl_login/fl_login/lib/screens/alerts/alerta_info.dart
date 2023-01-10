import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class AlertaInfo extends StatelessWidget {
  const AlertaInfo({
    super.key,
    required this.child,
    required this.titulo,
    required this.texto
    //required this.funcionCerrar,
  });

  final Widget child;
  final String titulo;
  final String texto;
    

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text(titulo),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(100),
              topEnd: Radius.circular(100))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            texto,
            style: const TextStyle(color: AppTheme.textoGeneral),
          )
        ],
      ),
      actions: [
        child
      ],
    );
  }
}
