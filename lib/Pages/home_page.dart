import 'package:first_app/Widgets/clockface_widgets.dart';
import 'package:first_app/Widgets/date_container.dart';
import 'package:first_app/Widgets/hands.dart';
import 'package:first_app/Widgets/small_hour_markers.dart';
import 'package:first_app/Widgets/space_sun_and_moon.dart';
import 'package:first_app/Widgets/sun_moon_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        //toolbarHeight: 30,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ALARM',
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
      ),
      body: LayoutBuilder(
        builder: (_, constraint) {
          return Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            decoration: BoxDecoration(gradient: backgroundGradient),
            child: Stack(
              children: <Widget>[
                const SizedBox(height: 100),
                // Clock Face
                SizedBox(
                  width: constraint.maxWidth,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
