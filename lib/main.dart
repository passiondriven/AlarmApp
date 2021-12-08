import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const gap = 25.0;
const handWidth = 2.5;
const minHandAngle = 8 * pi / 4;
const hourHandAngle = 2 * pi / 4;

Future changeColor() async {
  const style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  );

  SystemChrome.setSystemUIOverlayStyle(style);
}

void main() {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
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
      //showPerformanceOverlay: true,
      //debugShowMaterialGrid: true,
      //showSemanticsDebugger: true,

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
                      SizedBox(
                        width: x.maxWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Spacer(),
                            Container(
                              width: 350,
                              height: 350,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                //boxShadow: <BoxShadow>[
                                //  BoxShadow(
                                //    color: Color(0x30FFFFFF),
                                //    blurRadius: 3,
                                //    offset: Offset(-2, -2),
                                //    spreadRadius: 1,
                                //  ),
                                //  BoxShadow(
                                //    color: Color(0x30000000),
                                //    blurRadius: 3,
                                //    offset: Offset(2, 2),
                                //    spreadRadius: 1,
                                //  ),
                                //],
                                //color: Colors.transparent,
                                color: Color(0xFF3A456B),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(350 / 2),
                                ),
                              ),
                              child: LayoutBuilder(builder: (_, constaint) {
                                return Stack(
                                  children: [
                                    const MainCircle(),
                                    const ShadowCircle(), // blue
                                    const LightCircle(), //Minute hand
                                    Positioned(
                                      top: 20,
                                      right: constaint.maxWidth / 2 -
                                          handWidth / 2,
                                      child: Transform.rotate(
                                        origin: Offset(
                                          0,
                                          constaint.maxHeight / 4 - 20 / 2,
                                        ),
                                        angle: minHandAngle,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          height: constaint.maxHeight / 2 - 20,
                                          width: handWidth,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    //hour hand
                                    Positioned(
                                      top: constaint.maxHeight / 2 -
                                          constaint.maxHeight / 3,
                                      right: constaint.maxWidth / 2 -
                                          handWidth / 2,
                                      child: Transform.rotate(
                                        origin: Offset(
                                          0,
                                          constaint.maxHeight / (3 * 2),
                                        ),
                                        angle: hourHandAngle,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          height: constaint.maxHeight / 3,
                                          width: handWidth,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'HOUR',
                        style: GoogleFonts.jost(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      HourDial(width: x.maxWidth),
                      const SizedBox(height: 20),
                      Text(
                        'MINUTE',
                        style: GoogleFonts.jost(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      HourDial(width: x.maxWidth),
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

class HourDial extends StatefulWidget {
  final double width;
  static const List _list = [
    ' ',
    ' ',
    ' ',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    ' ',
    ' ',
    ' ',
  ];

  const HourDial({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<HourDial> createState() => _HourDialState();
}

class _HourDialState extends State<HourDial> {
  double position = 0;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    //_scrollController.addListener(_onScrollEvent);
  }

  @override
  void dispose() {
    super.dispose();
    // _scrollController.removeListener(_onScrollEvent);
  }

  int scroll = 0;
  void _onScrollEvent() {
    scroll++;
    print('Scrolling ' + scroll.toString());
  }

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
            /*Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  hourText(' '),
                  hourText(' '),
                  hourText(' '),
                  hourText(' '),
                  ...callTextObject(),
                  hourText(' '),
                  hourText(' '),
                  hourText(' '),
                ],
              ),
            ),
            */
            /*TextButton(
                onPressed: () {
                  position += widget.width / 7;
                  if (position > 730.0) position = 0;
                  print(position);
                  _scrollController.animateTo(position,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: const Text('Change Position')),
            */
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    scroll++;
                    print('ENDED  : ' + scroll.toString());
                  }
                  return true;
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount:
                      HourDial._list.length, //physics: ScrollPhysics(parent),
                  itemBuilder: (ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        HourDial._list[index].toString(),
                        style: GoogleFonts.jost(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      height: 30,
                      width: widget.width / 7,
                      //decoration: BoxDecoration(
                      //  border: Border.all(width: 1, color: Colors.yellow),
                      //),
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

class MainCircle extends StatelessWidget {
  const MainCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x60000000),
        borderRadius: BorderRadius.circular(250),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 0,
      ),
      alignment: Alignment.center,
      width: 350,
      height: 350,
      child: const CircleAvatar(
        radius: 1.5,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class ShadowCircle extends StatelessWidget {
  const ShadowCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class LightCircle extends StatelessWidget {
  const LightCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
