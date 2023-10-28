import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/screen/auth/setnewpassword.dart';
import 'package:ancientmysticmusic/utils/buttonwidgetloader.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apis/loginapi.dart';
import '../../main.dart';
import '../../page_routes/routes.dart';
import '../../utils/button_widget.dart';
import '../../utils/colors.dart';
import '../../utils/stack_bar.dart';
import '../../utils/string_file.dart';
import '../../utils/textform.dart';
import '../../utils/menubar.dart';

class OtpVerify extends StatefulWidget {
  final String? id;
  final String? email;
  final String? userid;
  final String? pagetype;
  const OtpVerify({Key? key, this.id, this.email, this.pagetype, this.userid})
      : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  bool isLoading = false;
  String _finalotp = '';
  String _error = '';

  Future<void> fetchdata() async {
    if (_finalotp.length == 6) {
      var data = {
        'id': widget.id,
        'email': widget.email,
        'otp': _finalotp,
      };
      LoginApi registerresponse = LoginApi(data);
      var response;
      if (widget.pagetype == StringFile.forgot_password) {
        response = await registerresponse.forgetverifyOtp();

        // FORGETVERIFYOTP

        print(response);
        print(data.toString());
        if (response['status'].toString().toLowerCase() == "true") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SetPassScreen(email: widget.email),
          //   ),
          // );

          Navigator.pushNamed(context, Routes.setnewPassword, arguments: {
            StringFile.email: widget.email,
            StringFile.id: widget.id,
          });
          DialogHelper.showFlutterToast(
              strMsg: "Otp Verification Done Successfully");
        } else {
          DialogHelper.showFlutterToast(
              strMsg: "Invalid OTP && Invalid Email Address .. Try Again!!!");
          setState(() {
            _error = response['error'];
          });
        }
      } else {
        // response = await registerresponse.forgetverifyOtp();
        response = await registerresponse.verifyOtp();
        print(response);
        print(data.toString());
        if (response['status'].toString().toLowerCase() == "true") {
          print('Registration Successful');

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          MyApp.userid = response['data']['id'].toString();
          MyApp.email_VALUE = response['data']['email'];

          sharedPreferences.setString(
              StringFile.userid, response['data']['id'].toString());

          sharedPreferences.setString(
              StringFile.email, response['data']['email'].toString());

          DialogHelper.showFlutterToast(strMsg: "Registration Successful");

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.bottomNav, (route) => false);
        } else {
          DialogHelper.showFlutterToast(strMsg: response['error']);
          setState(() {
            _error = response['error'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          StackBar(),
          Container(
            height: 75.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: colorSecondry,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.w),
                    topRight: Radius.circular(5.w))),
            child: Padding(
              padding: EdgeInsets.only(top: 6.0.h, left: 2.0.h, right: 2.0.h),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Verification",
                          style: Style_File.title.copyWith(
                            color: colorWhite,
                            fontSize: 18.0.sp,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 3.h,
                      color: colorPrimary,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Enter Your OTP",
                      style: Style_File.title.copyWith(color: colorWhite),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      cursorColor: colorBlack,
                      animationType: AnimationType.fade,
                      pastedTextStyle: TextStyle(
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          disabledColor: colorWhite,
                          borderRadius: BorderRadius.circular(1.h),
                          fieldHeight: 100.w / 8,
                          fieldWidth: 100.w / 8,
                          activeFillColor: Colors.white,
                          inactiveColor: colorPrimary,
                          inactiveFillColor: colorWhite,
                          selectedFillColor: colorWhite,
                          selectedColor: Colors.greenAccent,
                          activeColor: Colors.blue),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        print("Completed");
                        _finalotp = v;
                        print(_finalotp);
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          // currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      _error,
                      style: Style_File.subtitle
                          .copyWith(color: colorPrimary, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Please enter the OTP here for Verification",
                      style: Style_File.subtitle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    !isLoading
                        ? ButtonWidget(
                            text: 'Verify',
                            onTap: () {
                              setState(() {
                                _error = '';
                              });

                              fetchdata();
                            })
                        : ButtonWidgetLoader(),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
