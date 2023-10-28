// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Utils {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  requestingPermissionForIOS() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidNotification? android = message.notification?.android;
    RemoteNotification? notification = message.notification;

    print(notification);
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification!.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android?.smallIcon,
          // other properties...
        ),
        // iOS: IOSNotificationDetails(presentAlert: true, presentSound: true),
      ),
      payload: 'Default_Sound',
    );
  }

  initfirebasesetting() {
    print("object init");
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    // iOS: initializationSettingsIOS);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  makingPhoneCall(String call) async {
    var url = Uri.parse(Platform.isIOS ? 'tel://$call' : 'tel:$call');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print(url);
      throw 'Could not launch $url';
    }
  }

  //payment
  Map<String, dynamic>? paymentIntentData;
  Future makePayment() async {
    // try {
    //   paymentIntentData =
    //       await createPaymentIntent('1', 'USD'); //json.decode(response.body);
    //   // print('Response body==>${response.body.toString()}');
    //   await Stripe.instance
    //       .initPaymentSheet(
    //           paymentSheetParameters: SetupPaymentSheetParameters(
    //               paymentIntentClientSecret:
    //                   paymentIntentData!['client_secret'],
    //               // applePay: true,
    //               // googlePay: true,
    //               // testEnv: true,
    //               style: ThemeMode.dark,
    //               // merchantCountryCode: 'US',
    //               merchantDisplayName: 'ANNIE'))
    //       .then((value) {});

    //   ///now finally display payment sheeet
    //   displayPaymentSheet();
    // } catch (e, s) {
    //   print('exception:$e$s');
    // }
  }

  displayPaymentSheet() async {
    // try {
    //   // await Stripe.instance
    //   //     .presentPaymentSheet(
    //   //         parameters: PresentPaymentSheetParameters(
    //   //   clientSecret: paymentIntentData!['client_secret'],
    //   //   confirmPayment: true,
    //   // ))
    //   //     .then((newValue) {
    //   //   print('payment intent' + paymentIntentData!['id'].toString());
    //   //   print(
    //   //       'payment intent' + paymentIntentData!['client_secret'].toString());
    //   //   print('payment intent' + paymentIntentData!['amount'].toString());
    //   //   print('payment intent' + paymentIntentData.toString());
    //   //   //orderPlaceApi(paymentIntentData!['id'].toString());
    //   //   // ScaffoldMessenger.of(context)
    //   //   //     .showSnackBar(SnackBar(content: Text("paid successfully")));

    //   //   paymentIntentData = null;
    //   // }).onError((error, stackTrace) {
    //   //   print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
    //   // });
    // } on StripeException catch (e) {
    //   print('Exception/DISPLAYPAYMENTSHEET==> $e');
    //   // showDialog(
    //   //     context: context,
    //   //     builder: (_) => AlertDialog(
    //   //           content: Text("Cancelled "),
    //   //         ));
    // } catch (e) {
    //   print('$e');
    // }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Lk677CX1eRrOBKdYm9pkMD6FNM8z3Qt6mz7JpkdAB4uVpzLnTOKJ7skue2n5zJI1ITa4J6XwTRYa327O2QjZn2a00mYjjQd1h',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  //Download
  // Future<void> _download() async {
  //   final dir = await _getDownloadDirectory();
  //   final isPermissionStatusGranted = await _requestPermissions();

  //   if (isPermissionStatusGranted) {
  //     final savePath = path.join(dir.path, _fileName);
  //     await _startDownload(savePath);
  //   } else {
  //     // handle the scenario when user declines the permissions
  //   }
  // }
  // Future<bool> _requestPermissions() async {
  //   var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

  //   if (permission != PermissionStatus.granted) {
  //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //     permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  //   }

  //   return permission == PermissionStatus.granted;
  // }

  // Future<Directory> _getDownloadDirectory() async {
  //   if (Platform.isAndroid) {
  //     // Directory documents = await getApplicationDocumentsDirectory();
  //     Directory? tempDir = await getExternalStorageDirectory();
  //     // String tempPath = tempDir.path;
  //     // return await DownloadsPathProvider.downloadsDirectory;
  //     return tempDir!;
  //   } else {
  //     Directory? tempDir = await getApplicationDocumentsDirectory();
  //     // String tempPath = tempDir.path;
  //     // return await DownloadsPathProvider.downloadsDirectory;
  //     return tempDir;
  //   }

  //   // in this example we are using only Android and iOS so I can assume
  //   // that you are not trying it for other platforms and the if statement
  //   // for iOS is unnecessary

  //   // iOS directory visible to user
  // }

  Future downloadFile(String url, String name) async {
    final appStorage = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    print(appStorage);
    // final file = File('${appStorage.path}/$name');
    File file;

    // try {
    http.Client _client = new http.Client();

    String dir = Platform.isAndroid
        ? (await getExternalStorageDirectory())!.path //FOR ANDROID
        : (await getApplicationSupportDirectory()).path;
    file = new File('$dir/${name}');
    print(file);
    // final taskId = await FlutterDownloader.enqueue(
    //   url: url,
    //   headers: {}, // optional: header send with url (auth token etc)
    //   savedDir: dir,
    //   showNotification:
    //       true, // show download progress in status bar (for Android)
    //   openFileFromNotification:
    //       true, // click on notification to open downloaded file (for Android)
    // );
    // print(taskId);

    print("object write");
    print(url);
    var req = await _client.get(Uri.parse(url));
    print(req);
    var bytes = req.bodyBytes;
    print("bytes $bytes");
    await file.writeAsBytes(bytes);
    print(file);
    print("object ok file");

    return file;

    // } catch (e) {
    //   print(e);
    //   return file;
    // }
  }
}
