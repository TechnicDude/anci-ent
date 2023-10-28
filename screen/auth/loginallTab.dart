import 'package:ancientmysticmusic/screen/auth/login.dart';
import 'package:ancientmysticmusic/screen/auth/signup.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/stack_bar.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginallTab extends StatefulWidget {
  const LoginallTab({Key? key}) : super(key: key);

  @override
  State<LoginallTab> createState() => _LoginallTabState();
}

class _LoginallTabState extends State<LoginallTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        StackBar(),
        Container(
          height: 75.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: colorSecondry,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.w),
                  topRight: Radius.circular(5.w))),
          child: DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,

                          indicatorColor: Colors.white,
                          labelStyle: TextStyle(
                              fontSize: 16.0.sp,
                              fontFamily: 'Amazon'), //For Selected tab
                          unselectedLabelStyle: TextStyle(
                              fontSize: 16.0.sp,
                              fontFamily: 'Amazon'), //For Un-selected Tabs

                          tabs: [
                            Tab(
                              text: 'Sign In',
                            ),
                            Tab(text: 'Sign Up'),
                          ],
                        ),
                      ),
                      Container(
                          height: 66.h, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            LoginScreen(),
                            SignupScreen(),
                          ]))
                    ]),
              )),
        ),
      ]),
    );
  }
}
