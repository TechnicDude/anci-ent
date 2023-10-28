import 'package:ancientmysticmusic/screen/auth/loginallTab.dart';
import 'package:ancientmysticmusic/screen/auth/otpverify.dart';
import 'package:ancientmysticmusic/utils/app_validator.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../apis/loginapi.dart';
import '../../db_helper/dialog_helper.dart';
import '../../page_routes/routes.dart';
import '../../utils/button_widget.dart';
import '../../utils/colors.dart';
import '../../utils/stack_bar.dart';
import '../../utils/style_file.dart';
import '../../utils/textform.dart';

class ForgetPassword extends StatefulWidget {
  bool setvalue = false;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _form = GlobalKey<FormState>();
  bool _isValid = false;
  String _error = '';

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;
  TextEditingController emailController = TextEditingController();

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
              padding: EdgeInsets.only(top: 6.h, left: 2.0.h, right: 2.0.h),
              child: Column(
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "Forget Password",
                      style: Style_File.title.copyWith(color: colorWhite),
                    ),
                  ]),
                  Divider(
                    height: 3.h,
                    color: colorPrimary,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormScreen(
                          //  textEditingController: _emailController,
                          hinttext: "Email Address/Phone Number",

                          textEditingController: emailController,
                          validator: AppValidator.emailValidator,
                        ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // Text(
                        //   _error,
                        //   style: Style_File.subtitle
                        //       .copyWith(color: Colors.red, fontSize: 15.sp),
                        // ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                            "please enter the email ID or mobile number. we will send you a OTP via email/SMS",
                            style: Style_File.subtitle),
                        SizedBox(
                          height: 5.h,
                        ),
                        ButtonWidget(
                          text: 'Submit Request',
                          onTap: () {
                            setState(() {
                              _error = '';
                            });
                            if (isLoading) {
                              return;
                            }

                            forgotPassword(emailController.text);

                            // setState(() {
                            //   errror = '';
                            // });

                            // if (isLoading) {
                            //   return;
                            // }

                            // if (emailController.text.toString().isEmpty) {
                            //   DialogHelper.showFlutterToast(
                            //       strMsg: "Please Enter Your Email id ");
                            //   // scaffoldMessenger.showSnackBar(const SnackBar(
                            //   //     content: Text(
                            //   //         "Please enter your verification code")));
                            //   setState(() {
                            //     isLoading = false;
                            //   });
                            // } else {
                            //   forgotPassword(
                            //     emailController.text.toString(),
                            //   );
                            // }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Remember your password?',
                        style: Style_File.subtitle,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Sign In',
                            style: Style_File.subtitle
                                .copyWith(color: colorPrimary, fontSize: 15.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginallTab()));
                              },
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  forgotPassword(String email) async {
    if (_form.currentState!.validate()) {
      var data = {
        'email': email,
      };
      print(email.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.forgetpassword();
      if (response['status'].toString() == "true") {
        Navigator.pushNamed(context, Routes.otpVerify, arguments: {
          StringFile.email: email,
          StringFile.pagetype: StringFile.forgot_password,
          StringFile.id: response['data']['id'],
        });
      } else {
        setState(() {
          _error = response['_error'].toString();
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
