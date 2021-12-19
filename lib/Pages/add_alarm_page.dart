import 'dart:math';

import 'package:first_app/Widgets/dial.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../Widgets/date_container.dart';
import '../Widgets/hands.dart';
import '../Widgets/small_hour_markers.dart';
import '../Widgets/clockface_widgets.dart';
import '../Widgets/space_sun_and_moon.dart';
import '../Widgets/sun_moon_switch.dart';

class AddAlarmPage extends StatelessWidget {
  static const routeName = '/AddAlarmPage';
  AddAlarmPage({Key? key}) : super(key: key);

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

  final AppBar appbar = AppBar(
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
          onPressed: () {},
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appbar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Transform.translate(
            offset: const Offset(-200, 0),
            child: Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(0.5 * pi / 2)
              //..translate(100, 0, 0) //
              ,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(gradient: backgroundGradient),
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
                                  style: GoogleFonts.jost(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'SAVE',
                                  style:
                                      GoogleFonts.jost(color: Colors.redAccent),
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
          );
        },
      ),
    );
  }
}
