import 'dart:math';

import 'package:first_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const gap = 25.0;
const handWidth = 1.25;

class Hands extends StatefulWidget {
  const Hands({Key? key}) : super(key: key);

  final minHandAngle = 2 * pi / 3;
  final hourHandAngle = 4.5 * pi / 4;

  @override
  _HandsState createState() => _HandsState();
}

class _HandsState extends State<Hands> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double minAngle = 0.0;
  double hourAngle = pi;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    //print(provider.hour.toString() + ' : ' + provider.min.toString());
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              TweenAnimationBuilder(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 200),
                  tween: Tween<double>(
                    begin: 0,
                    end: provider.min * pi / 30,
                  ),
                  builder: (_, double angle, ___) {
                    return MinuteHand(
                      constraint: constraints,
                      minHandAngle: angle,
                    );
                  }),
              TweenAnimationBuilder(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 400),
                  tween: Tween<double>(
                    begin: 0,
                    //end: provider.hour * pi / 6,
                    end:
                        provider.hour * pi / 6 + provider.min * pi / 6 * 1 / 60,

                    // 1 hour is pi / 6
                    // 1 hour is divided in 60 steps
                    // 1 min will have influence on the hour hand pi / 6 + min * pi / 6 / 60
                  ),
                  builder: (_, double angle, ___) {
                    return HourHand(
                      constraint: constraints,
                      hourHandAngle: angle,
                    );
                  }),
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
