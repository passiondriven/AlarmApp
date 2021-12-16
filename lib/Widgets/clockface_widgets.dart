import 'package:flutter/material.dart';

class MainCircle extends StatelessWidget {
  const MainCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 350,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x30FFFFFF),
              blurRadius: 1,
              offset: Offset(-1, -1),
              spreadRadius: 0.1,
            ),
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 1,
              offset: Offset(1, 1),
              spreadRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(350 / 2),
          ),
        ),
        alignment: Alignment.center,
        child: ColorFiltered(
          colorFilter:
              const ColorFilter.mode(Color(0x60000000), BlendMode.overlay),
          child: Container(
            width: 350,
            height: 350,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF3A456B),
            ),
            child: const CircleAvatar(
              radius: 1.5,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowCircle extends StatelessWidget {
  const ShadowCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 350,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(350 / 2),
          ),
          //color: Colors.red,
        ),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            gradient: const RadialGradient(
              colors: <Color>[
                Color(0x00000000),
                Color(0x30000000),
              ],
              center: AlignmentDirectional(0.1, 0.1),
              focal: AlignmentDirectional(0, 0),
              radius: 0.55,
              focalRadius: 0,
              stops: [0.85, 1],
            ),
            borderRadius: BorderRadius.circular(350),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 0,
          ),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class LightCircle extends StatelessWidget {
  const LightCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 350,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(350 / 2),
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            gradient: const RadialGradient(
              colors: <Color>[
                Color(0x00000000),
                Color(0x20FFFFFF),
              ],
              center: AlignmentDirectional(-0.1, -0.1),
              focal: AlignmentDirectional(0, 0),
              radius: 0.55,
              focalRadius: 0,
              stops: [0.85, 1],
            ),
            borderRadius: BorderRadius.circular(350),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 0,
          ),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
