import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
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
                  style: GoogleFonts.jost(color: Colors.white38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
