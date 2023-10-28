import 'dart:async';
import 'dart:io';
import 'package:ancientmysticmusic/screen/auth/locdb.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../page_routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils().requestingPermissionForIOS();
    Utils().initfirebasesetting();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("remote");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        Utils().showNotification(message);
      }
      if (Platform.isIOS) {
        if (notification != null) {
          Utils().flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  // android: AndroidNotificationDetails(
                  //   channel.id,
                  //   channel.name,
                  //   channelDescript
                  //ion: channel.description,
                  //   color: Colors.blue,
                  //   playSound: true,
                  //   icon: '@mipmap/ic_launcher',
                  // ),
                  // iOS: IOSNotificationDetails(),
                  ));
        }
      }
    });
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, homePageRoute);
  }

  homePageRoute() {
    if (LocDb().loginapp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.bottomNav, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.introScreen, (Route<dynamic> route) => false);

      //Routes.loginallTab, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Container(
        color: colorBlack,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          ImageFile.splash,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
