import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/notification/notificationui.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(
        title: Text('Notifications'),
        elevation: 10,
      ),
      body: NotificationUI(),
    );
  }
}
