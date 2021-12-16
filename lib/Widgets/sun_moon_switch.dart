import 'dart:math';

import 'package:flutter/material.dart';

class SunMoonSwitch extends StatefulWidget {
  const SunMoonSwitch({Key? key}) : super(key: key);

  @override
  _SunMoonSwitchState createState() => _SunMoonSwitchState();
}

class _SunMoonSwitchState extends State<SunMoonSwitch>
    with SingleTickerProviderStateMixin {
  var dayTimeDistance = 35.0;
  late final AnimationController _controller;

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
    return Center(
        child: Container(
      height: 350,
      width: 350,
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(
          0,
          -(350 / 2 / 2),
        ),
        child: GestureDetector(
          onTap: () {
            //print('tapped');
            if (dayTimeDistance == -35.0) {
              setState(() {
                dayTimeDistance = 35.0;
              });
            } else {
              setState(() {
                dayTimeDistance = -35.0;
              });
            }
          },
          child: TweenAnimationBuilder(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 250),
            tween: Tween<double>(
              begin: -35,
              end: dayTimeDistance,
            ),
            builder: (_, double position, ___) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 35,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35 / 2),
                      //color: Colors.red,
                    ),
                    child: SunInside(offset: position - 35),
                    //offset: dayTimeDistance - 35),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35 / 2),
                      //color: Colors.red,
                    ),
                    child: MoonInside(offset: position + 35),
                    //offset: dayTimeDistance + 35),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}

class MoonInside extends StatelessWidget {
  final double offset;
  const MoonInside({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      alignment: Alignment.center,
      child: Transform.translate(
        offset: Offset(
          offset,
          0,
          //-(350 / 2 / 2),
        ),
        child: Center(
          child: Container(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38 / 2),
            ),
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Container(
                height: 25,
                width: 25,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.redAccent[200],
                  borderRadius: BorderRadius.circular(25 / 2),
                ),
                child: Transform.translate(
                  offset: const Offset(10, 0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0x60000000),
                        BlendMode.overlay,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF3A456B),
                            borderRadius: BorderRadius.circular(28 / 2)),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28 / 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SunInside extends StatelessWidget {
  final double offset;
  const SunInside({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(
            offset,
            0,
            //-(350 / 2 / 2),
          ),
          child: Stack(
            children: [
              Transform.rotate(
                angle: pi / 2,
                child: Center(
                  child: Container(
                      height: 28, width: 1.5, color: Colors.redAccent),
                ),
              ),
              Transform.rotate(
                angle: pi / 4,
                child: Center(
                  child: Container(
                      height: 28, width: 1.5, color: Colors.redAccent),
                ),
              ),
              Transform.rotate(
                angle: pi,
                child: Center(
                  child: Container(
                      height: 28, width: 1.5, color: Colors.redAccent),
                ),
              ),
              Transform.rotate(
                angle: 3 * pi / 4,
                child: Center(
                  child: Container(
                      height: 28, width: 1.5, color: Colors.redAccent),
                ),
              ),
              Center(
                child: Container(
                  clipBehavior: Clip.none,
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16 / 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
