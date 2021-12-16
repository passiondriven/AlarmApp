import 'dart:math';

import 'package:flutter/material.dart';

const gap = 25.0;
const handWidth = 1.25;

class Hands extends StatefulWidget {
  const Hands({Key? key}) : super(key: key);

  final minHandAngle = 2 * pi / 3;
  final hourHandAngle = 4.5 * pi / 4;

  @override
  _HandsState createState() => _HandsState();
}

class _HandsState extends State<Hands> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              MinuteHand(
                constraint: constraints,
                minHandAngle: widget.minHandAngle,
              ),
              HourHand(
                constraint: constraints,
                hourHandAngle: widget.hourHandAngle,
              ),
            ],
          );
        },
      ),
    );
  }
}

class HourHand extends StatelessWidget {
  final BoxConstraints constraint;
  final double hourHandAngle;
  const HourHand({
    Key? key,
    required this.hourHandAngle,
    required this.constraint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: constraint.maxHeight / 2 - constraint.maxHeight / 3.5,
      right: constraint.maxWidth / 2 - handWidth / 2,
      child: Transform.rotate(
        origin: Offset(
          0,
          constraint.maxHeight / (3.5 * 2),
        ),
        angle: hourHandAngle,
        child: Container(
          alignment: Alignment.topCenter,
          height: constraint.maxHeight / 3.5,
          width: handWidth,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MinuteHand extends StatelessWidget {
  final BoxConstraints constraint;
  final double minHandAngle;
  const MinuteHand({
    Key? key,
    required this.minHandAngle,
    required this.constraint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: constraint.maxHeight / 2 - constraint.maxHeight / 2.5,
      right: constraint.maxWidth / 2 - handWidth / 2,
      child: Transform.rotate(
        origin: Offset(
          0,
          constraint.maxHeight / (2.5 * 2),
        ),
        angle: minHandAngle,
        child: Container(
          alignment: Alignment.topCenter,
          height: constraint.maxHeight / 2.5,
          width: handWidth,
          color: Colors.white,
        ),
      ),
    );
  }
}
