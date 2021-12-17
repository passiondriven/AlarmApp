import 'package:first_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Dial extends StatefulWidget {
  final double width;
  final int start;
  final int end;
  final String type;

  const Dial(
      {Key? key,
      required this.width,
      required this.start,
      required this.end,
      required this.type})
      : super(key: key);

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> {
  late final List _list = [];
  late double _increment;
  final ScrollController _scrollController = ScrollController();
  var provider;
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
    provider = Provider.of<UserProvider>(context, listen: false);
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
                  if (widget.type == 'hour') {
                    if (scrollNotification is ScrollUpdateNotification) {
                      var _index =
                          (_scrollController.position.pixels / _increment)
                              .round();

                      if (_index > 12) {
                        if (provider.appmProvider != true) {
                          provider.setTimeOfDay(true);
                        }
                      } else {
                        if (provider.appmProvider == true) {
                          provider.setTimeOfDay(false);
                        }
                      }
                    }
                  }
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
