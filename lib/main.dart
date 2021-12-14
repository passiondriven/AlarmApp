import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const gap = 25.0;
const handWidth = 1.25;
const minHandAngle = 8 * pi / 3;
const hourHandAngle = 5.5 * pi / 4;

Future changeColor() async {
  const style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  );

  SystemChrome.setSystemUIOverlayStyle(style);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) {
    changeColor();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color(0xFF3A456B),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ADD ALARM',
            style: GoogleFonts.jost(),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                child: const Icon(Icons.menu)),
          ],
        ),
        body: LayoutBuilder(
          builder: (_, size) => Container(
            width: size.maxWidth,
            height: size.maxHeight,
            decoration: const BoxDecoration(
              //border: Border.all(color: Colors.yellow),
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF3A456B),
                  Color(0x373A456B),
                  //Color(0xA0000000),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.8],
              ),
            ),
            child: LayoutBuilder(
              builder: (_, x) => Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 100),
                      // Clock face

                      SizedBox(
                        width: x.maxWidth,
                        child: Stack(
                          children: <Widget>[
                            // main circle
                            const MainCircle(),
                            // light cicle
                            const LightCircle(),
                            // shadow circle
                            const ShadowCircle(),
                            // moon
                            Center(
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
                                  child: const Moon()),
                            ),
                            const MoonInside(),

                            const DateStack(),

                            //hour markers
                            const SmallHourMarkers(),

                            //Minutes
                            Center(
                              child: Container(
                                height: 350,
                                width: 350,
                                decoration: const BoxDecoration(
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(350 / 2),
                                  ),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Stack(
                                      children: [
                                        MinuteHand(constraint: constraints),
                                        HourHand(constraint: constraints),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
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
                      Dial(width: x.maxWidth, start: 0, end: 23),
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
                      Dial(width: x.maxWidth, start: 0, end: 59),
                      Expanded(
                        child: SizedBox(
                          height: 25,
                          width: x.maxWidth,
                          //decoration: BoxDecoration(color: Colors.red),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'CANCEL',
                                    style:
                                        GoogleFonts.jost(color: Colors.white),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoonInside extends StatelessWidget {
  const MoonInside({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(
          0,
          -(350 / 2 / 2),
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

class HourHand extends StatelessWidget {
  final BoxConstraints constraint;
  const HourHand({
    Key? key,
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
  const MinuteHand({
    Key? key,
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

class SmallHourMarkers extends StatelessWidget {
  const SmallHourMarkers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350,
        width: 350,
        child: Stack(
          children: [
            //Hour hands (small)
            Transform.translate(
              offset: Offset(0, 350 / 2 - 25),
              child: Center(
                child: Container(
                  height: 20,
                  width: 1,
                  color: Colors.white30,
                ),
              ),
            ),
            //Hour hands (small)
            Transform.translate(
              offset: Offset(350 / 2 - 25, 0),
              child: Center(
                child: Container(
                  height: 1,
                  width: 20,
                  color: Colors.white30,
                ),
              ),
            ),
            //Hour hands (small)
            Transform.translate(
              offset: Offset(-(350 / 2 - 25), 0),
              child: Center(
                child: Container(
                  height: 1,
                  width: 20,
                  color: Colors.white30,
                ),
              ),
            ),
            //Hour hands (small)
            Transform.translate(
              offset: Offset(0, -(350 / 2 - 25)),
              child: Center(
                child: Container(
                  height: 20,
                  width: 1,
                  color: Colors.white30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Moon extends StatelessWidget {
  const Moon({
    Key? key,
  }) : super(key: key);

  /*@override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -(350 / 2 / 2)),
      child: Center(
        //main container
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
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
                child: Container(
                  alignment: Alignment.center,
                  height: 36,
                  width: 36,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0x60000000),
                    borderRadius: BorderRadius.circular(36 / 2),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.redAccent[200],
                  borderRadius: BorderRadius.circular(25 / 2),
                ),
                child: Transform.translate(
                  offset: const Offset(10, 0),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(0x60000000), BlendMode.overlay),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A456B),
                        borderRadius: BorderRadius.circular(25 / 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  // WORKING SAFE
/*  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -(350 / 2 / 2)),
      child: Stack(
        children: [
          Center(
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
                colorFilter: const ColorFilter.mode(
                    Color(0x60000000), BlendMode.overlay),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A456B),
                    borderRadius: BorderRadius.circular(36 / 2),
                    //boxShadow: const <BoxShadow>[
                    //  BoxShadow(
                    //    offset: Offset(-1, -1),
                    //    color: Color(0x80000000),
                    //    blurRadius: 1,
                    //    spreadRadius: 0.3,
                    //  ),
                    //  BoxShadow(
                    //    offset: Offset(1, 1),
                    //    color: Color(0x30FFFFFF),
                    //    blurRadius: 1,
                    //    spreadRadius: 0.3,
                    //  ),
                    //],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
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
    );
  }
}

class DateStack extends StatelessWidget {
  const DateStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, (350 / 2 / 2)),
      child: Center(
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
          child: Stack(
            children: [
              Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  height: 26,
                  width: 65,
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3A456B),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(26 / 2),
                        right: Radius.circular(26 / 2)),
                  ),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(0x60000000), BlendMode.overlay),
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3A456B),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(26 / 2),
                            right: Radius.circular(26 / 2)),
                        boxShadow: <BoxShadow>[
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
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'MON 9',
                  style: GoogleFonts.jost(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class Dial extends StatefulWidget {
  final double width;
  final int start;
  final int end;

  const Dial({
    Key? key,
    required this.width,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> {
  late final List _list = [];
  late double _increment;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _increment = widget.width / 7;
    _list.add(' ');
    _list.add(' ');
    _list.add(' ');
    for (int x = widget.start; x <= widget.end; x++) {
      _list.add(x.toString());
    }
    _list.add(' ');
    _list.add(' ');
    _list.add(' ');
    //print('increment : ' + _increment.toString());
    //_scrollController.addListener(_onScrollEvent);
  }

  @override
  void dispose() {
    super.dispose();
    // _scrollController.removeListener(_onScrollEvent);
  }

  bool manualScroll = false;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.purple,
            Colors.transparent,
            Colors.transparent,
            Colors.purple,
          ],
          stops: [0.02, 0.50, 0.50, 0.98],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 60,
        width: widget.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if (manualScroll == false) {
                      setState(() {
                        manualScroll = true;
                      });

                      var _index =
                          (_scrollController.position.pixels / _increment)
                              .round();

                      var _scrollPixel = (_increment * _index).toInt();
                      Future.delayed(
                        const Duration(milliseconds: 2),
                        () => _scrollController
                            .animateTo(_scrollPixel.toDouble(),
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeInOut)
                            .then(
                              (value) => setState(
                                () {
                                  manualScroll = false;
                                },
                              ),
                            ),
                      );
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: _list.length, //physics: ScrollPhysics(parent),
                  itemBuilder: (ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        _list[index].toString(),
                        style: GoogleFonts.jost(
                          //fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      height: 30,
                      width: widget.width / 7,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              height: 3,
              width: widget.width,
              color: Colors.white60,
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Container(
                height: 12,
                width: 4,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
