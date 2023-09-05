

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Designtool extends StatefulWidget {
  Designtool({Key? key}) : super(key: key);

  @override
  State<Designtool> createState() => _DesigntoolState();
}

class _DesigntoolState extends State<Designtool> {
  bool isdrag = false;
  double _x = 0.0;
  double _y = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
        child : Container(
          child: Stack(
            children: [ Positioned(
              left: _x,
              top: _y,
              child: Draggable(
                child: FlutterLogo(size: 50),
                feedback: FlutterLogo(size: 50,),
                childWhenDragging: FlutterLogo(size: 50,textColor: Colors.grey),
                onDragEnd: (dragDetails) {
                  setState(() {

                    _x = dragDetails.offset.dx;
                    // if applicable, don't forget offsets like app/status bar
                    _y = dragDetails.offset.dy -117  ;
                  });
                },
              ),
            ),
          ]
          ),
        )

    );
  }
}
