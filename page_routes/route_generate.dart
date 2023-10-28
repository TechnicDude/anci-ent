import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/provider/PaymenthistoryProvider.dart';
import 'package:ancientmysticmusic/provider/aboutprovider.dart';
import 'package:ancientmysticmusic/provider/categoriesprovider.dart';
import 'package:ancientmysticmusic/provider/dashboardprovider.dart';
import 'package:ancientmysticmusic/provider/privacyprovider.dart';
import 'package:ancientmysticmusic/provider/profileuserprovider.dart';
import 'package:ancientmysticmusic/provider/songlistprovider.dart';
import 'package:ancientmysticmusic/provider/termsprovider.dart';
import 'package:ancientmysticmusic/screen/albums/albumscreen.dart';
import 'package:ancientmysticmusic/screen/artists/artistscreen.dart';
import 'package:ancientmysticmusic/screen/auth/otpverify.dart';
import 'package:ancientmysticmusic/screen/category/category.dart';
import 'package:ancientmysticmusic/screen/category/categorysong.dart';
import 'package:ancientmysticmusic/screen/downloads/downloads.dart';
import 'package:ancientmysticmusic/screen/home/TabHome.dart';
import 'package:ancientmysticmusic/screen/home/bottomnav.dart';
import 'package:ancientmysticmusic/screen/home/recentplaylist.dart';
import 'package:ancientmysticmusic/screen/library/libraryscreen.dart';
import 'package:ancientmysticmusic/screen/notification/notification.dart';
import 'package:ancientmysticmusic/screen/profile/editprofile.dart';
import 'package:ancientmysticmusic/screen/profile/profile.dart';
import 'package:ancientmysticmusic/screen/recentlyplayed/recentplayed.dart';
import 'package:ancientmysticmusic/screen/searchscreen/searchscreen.dart';
import 'package:ancientmysticmusic/screen/settings/PaymentHistory.dart';
import 'package:ancientmysticmusic/screen/settings/Paymentdone.dart';
import 'package:ancientmysticmusic/screen/settings/aboutscreen.dart';
import 'package:ancientmysticmusic/screen/settings/privacypolicy.dart';
import 'package:ancientmysticmusic/screen/settings/settingscreen.dart';
import 'package:ancientmysticmusic/screen/settings/transactionhistory.dart';
import 'package:ancientmysticmusic/screen/songs/playsong.dart';
import 'package:ancientmysticmusic/screen/settings/termscondition.dart';
import 'package:ancientmysticmusic/screen/songs/songlist.dart';
import 'package:ancientmysticmusic/screen/songs/songlistbyartitsScreen.dart';
import 'package:ancientmysticmusic/utils/screens/introscreen/intro_screen.dart';
import 'package:ancientmysticmusic/utils/screens/payment/addcartdesign.dart';
import 'package:ancientmysticmusic/utils/screens/addtocard.dart';
import 'package:ancientmysticmusic/utils/screens/payment/paymentscreen.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/webviewscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/auth/forgetpassword.dart';
import '../screen/auth/login.dart';
import '../screen/auth/loginallTab.dart';
import '../screen/auth/setnewpassword.dart';
import '../screen/auth/signup.dart';
import '../screen/home/home.dart';
import '../screen/splashscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    Widget widgetScreen;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = SplashScreen();
        break;

      case Routes.loginScreen:
        widgetScreen = LoginScreen();
        break;

      case Routes.signupScreen:
        widgetScreen = SignupScreen();
        break;
      case Routes.forgetPassword:
        widgetScreen = ForgetPassword();
        break;

      // case Routes.setnewPassword:
      //   widgetScreen = SetnewPassword();
      //   break;

      case Routes.setnewPassword:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = SetnewPassword(
          id: args[StringFile.id].toString(),
          password: args[StringFile.password].toString(),
          pagetype: args[StringFile.pagetype],
        );
        break;

      case Routes.otpVerify:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = OtpVerify(
          id: args[StringFile.id].toString(),
          email: args[StringFile.email].toString(),
          pagetype: args[StringFile.pagetype],
        );
        break;

      // case Routes.homeScreen:
      //   widgetScreen = HomeScreen();

      // break;

      case Routes.loginallTab:
        widgetScreen = LoginallTab();
        break;
      case Routes.bottomNav:
        widgetScreen = BottomNav();
        break;
      // case Routes.categoryScreen:
      //   widgetScreen = ChangeNotifierProvider<DashBoradProvider>(
      //       create: (BuildContext context) => DashBoradProvider(),
      //       child: CategoryScreen());
      //   break;

      // case Routes.categoryScreen:
      //   widgetScreen = CategoryScreen();
      //   break;

      // case Routes.recentPlaylist:
      //   widgetScreen = RecentPlaylist();
      //   break;

      case Routes.recentPlaylist:
        widgetScreen = ChangeNotifierProvider<DashBoradProvider>(
            create: (BuildContext context) => DashBoradProvider(),
            child: RecentPlaylist());

        break;

      case Routes.tabsHome:
        widgetScreen = TabsHome();
        break;

      // case Routes.profileScreen:
      //   widgetScreen = ChangeNotifierProvider<ProfileUserProvider>(
      //       create: (BuildContext context) => ProfileUserProvider(),
      //       child: ProfileScreen());
      //   break;

      // case Routes.albumScreen:
      //   widgetScreen = ChangeNotifierProvider<DashBoradProvider>(
      //       create: (BuildContext context) => DashBoradProvider(),
      //       child: AlbumScreen());
      //   break;

      // case Routes.artistScreen:
      //   widgetScreen = ArtistScreen();
      //   break;

      case Routes.downloadScreen:
        widgetScreen = DownloadScreen();
        break;

      case Routes.notifications:
        widgetScreen = Notifications();
        break;

      case Routes.libraryScreen:
        widgetScreen = ChangeNotifierProvider<DashBoradProvider>(
            create: (BuildContext context) => DashBoradProvider(),
            child: LibraryScreen());

        break;

      // case Routes.settingScreen:
      //   widgetScreen = ChangeNotifierProvider<ProfileUserProvider>(
      //       create: (BuildContext context) => ProfileUserProvider(),
      //       child: SettingScreen());
      //   break;

      // case Routes.categorySong:
      //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      //   widgetScreen = ChangeNotifierProvider<CategoriesProvider>(
      //       create: (BuildContext context) => CategoriesProvider(),
      //       child: CategorySong(
      //         title: args[StringFile.title],
      //         id: args[StringFile.ids],
      //       ));
      //   break;
      // case Routes.recentPlayed:
      //   widgetScreen = RecentPlayed();
      //   break;

      // case Routes.searchScreen:
      //   widgetScreen = SearchScreen();
      //   break;
      case Routes.playsongScreen:
        widgetScreen = PlaySongScreens();
        break;
      case Routes.songlistScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = ChangeNotifierProvider<SongListProvider>(
          create: (BuildContext context) => SongListProvider(),
          child: SongListScreens(
            albumdata: args[StringFile.albumdata],
          ),
        );
        break;

      // case Routes.songlistbyartistScreen:
      //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      //   widgetScreen = ChangeNotifierProvider<SongListProvider>(
      //     create: (BuildContext context) => SongListProvider(),
      //     child: SongListByArtistScreens(
      //       albumdata: args[StringFile.albumdata],
      //     ),
      //   );
      //   break;

      // case Routes.editProfileScreen:
      //   Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      //   widgetScreen = EditProfileScreen(
      //     profileuserdata: args[StringFile.profileuserdata],
      //   );
      //   break;

      case Routes.aboutScreen:
        widgetScreen = ChangeNotifierProvider<AboutProvider>(
          create: (BuildContext context) => AboutProvider(),
          child: AboutScreen(),
        );
        break;

      case Routes.termsCondition:
        widgetScreen = ChangeNotifierProvider<TermsProvider>(
          create: (BuildContext context) => TermsProvider(),
          child: TermsCondition(),
        );
        break;

      case Routes.privacyPolicy:
        widgetScreen = ChangeNotifierProvider<PrivacyProvider>(
          create: (BuildContext context) => PrivacyProvider(),
          child: PrivacyPolicy(),
        );
        break;

      // case Routes.editProfileScreen:
      //   widgetScreen = EditProfileScreen();
      //   break;

      case Routes.privacyPolicy:
        widgetScreen = PrivacyPolicy();
        break;

      case Routes.termsCondition:
        widgetScreen = TermsCondition();
        break;
      // case Routes.Addtocart:
      //   widgetScreen = Addtocart();
      //   break;

      case Routes.paymentScreen:
        widgetScreen = PaymentScreen();
        break;
      case Routes.introScreen:
        widgetScreen = IntroScreen();
        break;

      case Routes.paymentHistory:
        widgetScreen = PaymentHistory();
        break;
      case Routes.paymentDoneScreen:
        widgetScreen = PaymentDoneScreen();
        break;
      case Routes.payScreen:
        widgetScreen = PayScreen();
        break;

      case Routes.transactionHistory:
        widgetScreen = ChangeNotifierProvider<PaymenthistoryProvider>(
            create: (BuildContext context) => PaymenthistoryProvider(),
            child: TransactionHistory());
        break;

      // case Routes.transactionHistory:
      //   widgetScreen = TransactionHistory();
      //   break;

      default:
        widgetScreen = SplashScreen();
    }
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widgetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('ERROR'),
      ),
    );
  }
}
