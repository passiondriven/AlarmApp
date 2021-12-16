import 'package:flutter/material.dart';

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
              offset: const Offset(0, 350 / 2 - 25),
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
              offset: const Offset(350 / 2 - 25, 0),
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
              offset: const Offset(-(350 / 2 - 25), 0),
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
              offset: const Offset(0, -(350 / 2 - 25)),
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
