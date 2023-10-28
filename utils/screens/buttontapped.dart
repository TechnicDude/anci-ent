import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonTapped extends StatelessWidget {
  var icon;

  ButtonTapped({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 5.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorSecondry,
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white10,
              offset: Offset(-1.0, -1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0),
        ],
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Colors.grey[200]!,
        //       Colors.grey[300]!,
        //       Colors.grey[400]!,
        //       Colors.grey[500]!,
        //     ],
        //     stops: [
        //       0.1,
        //       0.3,
        //       0.8,
        //       1
        //     ]),
      ),
      child: Center(
        child: Container(
          height: 5.h,
          width: 5.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorSecondry,
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white10,
                  offset: Offset(-1.0, -1.0),
                  blurRadius: 1.0,
                  spreadRadius: 1.0),
            ],
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       Colors.grey[700]!,
            //       Colors.grey[600]!,
            //       Colors.grey[500]!,
            //       Colors.grey[200]!,
            //     ],
            //     stops: [
            //       0,
            //       0.1,
            //       0.3,
            //       1
            //     ]),
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 3.h,
            ),
          ),
        ),
      ),
    );
  }
}
