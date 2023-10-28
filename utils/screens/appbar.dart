import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarScreen extends StatelessWidget {
  List<Widget>? actions;
  String? title;
  final void Function()? onPressed;
  AppBarScreen({Key? key, this.title, this.actions, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      actions: actions,
      centerTitle: true,
      elevation: 10,
      backgroundColor: colorPrimary,
    );
  }
}
