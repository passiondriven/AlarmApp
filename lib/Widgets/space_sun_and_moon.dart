import 'package:flutter/material.dart';

class DayTimeSpace extends StatelessWidget {
  const DayTimeSpace({
    Key? key,
  }) : super(key: key);

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
        child: Transform.translate(
          offset: const Offset(0, -(350 / 2 / 2)),
          child: Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF3A456B),
              borderRadius: BorderRadius.circular(36 / 2),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(-1, -1),
                  color: Color(0x80000000),
                  blurRadius: 1,
                  spreadRadius: 0.3,
                ),
                BoxShadow(
                  offset: Offset(1, 1),
                  color: Color(0x30FFFFFF),
                  blurRadius: 1,
                  spreadRadius: 0.3,
                ),
              ],
            ),
            child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Color(0x60000000), BlendMode.overlay),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A456B),
                  borderRadius: BorderRadius.circular(36 / 2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
