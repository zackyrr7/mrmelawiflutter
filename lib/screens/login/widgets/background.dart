import 'package:flutter/material.dart';

import 'background_painter.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        )
      ],
    );
  }
}
