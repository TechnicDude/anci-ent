import 'package:ancientmysticmusic/screen/auth/loginallTab.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//import on board me dependency

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    //this is a page decoration for intro screen
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle:
          Style_File.title.copyWith(color: colorWhite, fontSize: 20.sp),
      // TextStyle(
      //     fontSize: 28.0,
      //     fontWeight: FontWeight.w700,
      //     color: Colors.white), //tile font size, weight and color
      bodyTextStyle:
          Style_File.subtitle.copyWith(color: colorWhite, fontSize: 16.sp),
      //body text size and color
      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      //decription padding
      imagePadding: EdgeInsets.all(20), //image padding
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 14, 69, 151),
            colorSecondry,
            colorPrimary,
            colorPrimary,
          ],
        ),
      ), //show linear gradient background of page
    );

    return IntroductionScreen(
      globalBackgroundColor: colorSecondry,
      // Color.fromARGB(255, 242, 17, 92),
      //main background of screen

      pages: [
        //set your page view here
        PageViewModel(
          title: "Welcome in AncientMystic ",
          body:
              "You are in greate Place to listen Trending Musics with artist...",
          image: Container(
            height: 18.h,
            child: introImage(
              ImageFile.logo,
            ),
          ),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Play",
          body: "Hot Trending, Latest music song even Online and Offline...",
          image: Container(
            height: 35.h,
            child: introImage(
              ImageFile.intro3,
            ),
          ),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Listen Now",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: Container(
            height: 40.h,
            child: introImage(
              ImageFile.intro2,
            ),
          ),
          decoration: pageDecoration,
        ),

        //add more screen here
      ],

      onDone: () => goHomepage(context), //go to home page on done
      onSkip: () => goHomepage(context), // You can override on skip
      showSkipButton: true,
      // skipFlex: 0,
      nextFlex: 0,
      skip: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Skip',
          style: TextStyle(color: Colors.white),
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: Text(
        'Continue',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0), //size of dots
        color: Colors.white, //color of dots
        activeSize: Size(22.0, 10.0),
        activeColor: colorPrimary, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return LoginallTab();
      //Home();
    }), (Route<dynamic> route) => false);
    //Navigate to home page and remove the intro screen history
    //so that "Back" button wont work.
  }

  Widget introImage(String assetName) {
    //widget to show intro image
    return Align(
      child: Image.asset('$assetName', width: 35.h),
      alignment: Alignment.bottomCenter,
    );
  }
}
