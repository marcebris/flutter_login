import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: 
         Stack(
          children:  [
             const _HeadBox(),

            const _HeaderIcon(),

            child
          ],
          )
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _HeadBox extends StatelessWidget {
  const _HeadBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _colorBackground(),
      child: Stack(
        children: const [
          Positioned(top: 90, left: 30, child: _BubbleBox()),
          Positioned(top: -40, left: -30, child: _BubbleBox()),
          Positioned(top: -50, right: -20, child: _BubbleBox()),
          Positioned(bottom: -50, left: 10, child: _BubbleBox()),
          Positioned(bottom: 120, right: 20, child: _BubbleBox())
        ],
      ),
    );
  }

  BoxDecoration _colorBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(68, 185, 130, 1),
          Color.fromRGBO(55, 149, 104, 1),
        ] )
    );
  }
}

class _BubbleBox extends StatelessWidget {
  const _BubbleBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: _bubbleBox(),
    );
  }

  BoxDecoration _bubbleBox() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: const Color.fromRGBO(68, 185, 130, 1)
    );
  }
}
