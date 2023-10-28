import 'package:ancientmysticmusic/screen/home/slider.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'colors.dart';

class ButtonHome2 extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const ButtonHome2({
    Key? key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        backgroundColor: colorWhite,
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        side:
            BorderSide(color: colorPrimary, width: 1, style: BorderStyle.solid),
        label: Text(
          text!,
          style: Style_File.cattitle,
        ),
      ),
    );
  }
}
