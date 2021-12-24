import 'dart:math';

import 'package:first_app/Widgets/dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';

import '../Widgets/date_container.dart';
import '../Widgets/hands.dart';
import '../Widgets/small_hour_markers.dart';
import '../Widgets/clockface_widgets.dart';
import '../Widgets/space_sun_and_moon.dart';
import '../Widgets/sun_moon_switch.dart';

class AddAlarmPage extends StatefulWidget {
  static const routeName = '/AddAlarmPage';
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          //
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final LinearGradient backgroundGradient = const LinearGradient(
    colors: <Color>[
      Color(0xFF3A456B),
      Color(0x373A456B),
      //Color(0xA0000000),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.1, 0.8],
  );
  final LinearGradient drawerGradient = const LinearGradient(
    colors: <Color>[
      Color(0xFF3A456B),
      Color(0x373A456B),
      //Color(0xA0000000),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.8],
  );

  double x = 0;
  double y = 0;
  double z = 0;

  /* final AppBar appbar = AppBar(
    //toolbarHeight: 30,
    foregroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      'ADD ALARM',
      style: GoogleFonts.jost(),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      splashRadius: 23,
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {},
    ),
    actions: <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 20),
        alignment: Alignment.center,
        child: IconButton(
          splashRadius: 23,
          icon: Icon(Icons.menu),
          onPressed: _onPressed(),
        ),
      ),
    ],
  );
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        //toolbarHeight: 30,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ADD ALARM',
          style: GoogleFonts.jost(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          splashRadius: 23,
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: IconButton(
              splashRadius: 23,
              icon: const Icon(Icons.menu),
              onPressed: () {
                setState(
                  () {
                    if (_animation.value == 0) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            //color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Container(
              width: constraints.maxWidth,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    height: constraints.maxHeight,
                    child: Transform.translate(
                      offset: Offset(-_animation.value * 200, 0),
                      child: Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(_animation.value * pi / 2 * 1),
                        child: Container(
                          //width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          decoration: BoxDecoration(
                            gradient: backgroundGradient,
                            //color: Colors.green,
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 100),
                              // Clock Face
                              SizedBox(
                                width: constraints.maxWidth,
                                height: 350,
                                child: Stack(
                                  children: const <Widget>[
                                    //main background circle
                                    MainCircle(),
                                    // light cicle
                                    LightCircle(),
                                    // shadow circle
                                    ShadowCircle(),

                                    DayTimeSpace(),
                                    DateContainer(),
                                    SmallHourMarkers(),
                                    SunMoonSwitch(),
                                    Hands(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              // Heading hour
                              Text(
                                'HOUR',
                                style: GoogleFonts.jost(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Hour dial
                              Dial(
                                width: constraints.maxWidth,
                                start: 0,
                                end: 23,
                                type: 'hour',
                              ),
                              const SizedBox(height: 20),
                              // Heading minutes
                              Text(
                                'MINUTE',
                                style: GoogleFonts.jost(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Minute dial
                              Dial(
                                width: constraints.maxWidth,
                                start: 0,
                                end: 59,
                                type: 'min',
                              ),
                              // Bottom buttons
                              Expanded(
                                child: SizedBox(
                                  height: 25,
                                  width: constraints.maxWidth,
                                  //decoration: BoxDecoration(color: Colors.red),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'CANCEL',
                                            style: GoogleFonts.jost(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'SAVE',
                                            style: GoogleFonts.jost(
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth - _animation.value * 200,
                    //left: screen width - ( tween value * width od the drawer ),
                    child: Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-(1 - _animation.value) * pi / 2),
                      child: Container(
                        height: constraints.maxHeight,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: backgroundGradient,
                          //color: Colors.green,
                        ),
                        child: Container(
                          height: 50,
                          width: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
