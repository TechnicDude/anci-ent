import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Style_File {
  static final edgeInsetsGeometry = EdgeInsets.only(
    left: 3.w,
  );
  static final edgeInsetsGeometryboth = EdgeInsets.only(left: 3.w, right: 3.w);
  static final edgeInsetsGeometrysubtitle =
      EdgeInsets.only(left: 1.w, right: 1.w);
  static final cardpadding =
      EdgeInsets.only(top: 1.0.h, left: 2.0.h, right: 2.0.h);
  static final cardinsidepadding =
      EdgeInsets.only(top: 1.0.h, left: 2.0.w, right: 2.0.w, bottom: 1.h);

  static final logintext = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
  );

  static final title = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white);
  static final songtitle = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white);
  static final songsubtitle =
      TextStyle(fontSize: 14.sp, color: Colors.white.withOpacity(.8));
  static final cattitle = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black);

  static final detailstitle = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black);

  static final subtitle = TextStyle(fontSize: 14.sp, color: Colors.white);
  static final detailsubtitle = TextStyle(fontSize: 15.sp, color: Colors.black);
}
