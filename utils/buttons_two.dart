import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final String icon;
  const ButtonWidget({
    Key? key,
    this.text, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38.w,
      height: 5.h,
      child: ElevatedButton(
        onPressed: () {},
        child: Wrap(
          children:  <Widget>[
            Icon(
              Icons.search,
              color: colorPrimary,
              size: 20.0,
            ),
            Text(
              text ?? '',
              style: TextStyle(
                  fontSize: 14, color: colorPrimary, fontFamily: 'Amazon'),
            ),
          ],
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
              colorWhite,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    side: BorderSide(
                      color: colorPrimary,
                    )))),
      ),
    );


  }
}
