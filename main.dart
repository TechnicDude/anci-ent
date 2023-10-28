import 'dart:io';

import 'package:ancientmysticmusic/firebase_options.dart';
import 'package:ancientmysticmusic/page_routes/route_generate.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/screen/auth/locdb.dart';
import 'package:ancientmysticmusic/screen/auth/login.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  return Utils().showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe.publishableKey =
  //     'pk_test_51Lk677CX1eRrOBKd401EoP27J7UCIflgiQ38007tmV50qcApssexeP2HKlSbXg6w8pwTgvDMWrj0W3VPgAFZMBJx004qt9v7wn';

  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
  print(statuses);
  HttpOverrides.global = new MyHttpOverrides();
  LocDb().loginapp = await LocDb().isLoggedIn();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('liked');
  await Hive.openBox('Recentsearch');
  await Hive.openBox('RecentlyPlayed');
  await Hive.openBox('playlists');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String? id;
  static String? userid;
  static String? AUTH_TOKEN_VALUE;
  static String? email_VALUE;

  static logout() async {
    googleSignIn.disconnect();
    MainController con = MainController();
    con.player.stop();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    userid = null;
    //   platform.PlatformState.firebaseMessaging.unsubscribeFromTopic(MyApp.LOGIN_ID_VALUE);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      return MultiProvider(
        providers: [
          ChangeNotifierProvider<DashBoradProvider>(
              create: (_) => DashBoradProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Roboto',
              appBarTheme: AppBarTheme(
                  backgroundColor: colorSecondry,
                  elevation: 0,
                  centerTitle: true)),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      );
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
