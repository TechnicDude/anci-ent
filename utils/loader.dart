import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoaderScreens extends StatelessWidget {
  const LoaderScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(
          color: colorPrimary,
        ),
      ),
    );
  }
}
