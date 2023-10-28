import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SocialButton extends StatefulWidget {
  final String? image;
  final String? text;
  final Function()? onPressed;
  const SocialButton({
    Key? key,
    this.image,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: SizedBox(
        width: 24.w,
        height: 5.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              widget.image ?? '',
              height: 2.h,
            ),
            SizedBox(
              width: 1.h,
            ),
            Text(
              widget.text ?? '',
              style: Style_File.subtitle.copyWith(color: colorGrey),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(
            colorWhite,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.h)),
                  side: BorderSide(
                    color: colorPrimary,
                  )))),
    );
  }
}
