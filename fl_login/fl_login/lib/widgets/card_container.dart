import 'package:flutter/material.dart';


class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.child});

  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        decoration: _createCardShape(),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0,5)
          )
        ]
      );
  }
}