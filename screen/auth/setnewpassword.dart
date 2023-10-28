import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/utils/app_validator.dart';
import 'package:ancientmysticmusic/utils/buttonwidgetloader.dart';
import 'package:ancientmysticmusic/utils/string_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../apis/loginapi.dart';
import '../../db_helper/dialog_helper.dart';
import '../../utils/button_widget.dart';
import '../../utils/colors.dart';
import '../../utils/stack_bar.dart';
import '../../utils/textform.dart';

class SetnewPassword extends StatefulWidget {
  final String? id;
  final String? password;
  final String? userid;
  final String? pagetype;
  const SetnewPassword(
      {Key? key, this.id, this.password, this.pagetype, this.userid})
      : super(key: key);

  @override
  State<SetnewPassword> createState() => _SetnewPasswordState();
}

class _SetnewPasswordState extends State<SetnewPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;

  bool _obscureText = true;
  bool _obscureText1 = true;

  String _error = '';

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();

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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Set New Password",
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormScreen(
                            textEditingController: passwordController,
                            hinttext: "New Password",
                            validator: AppValidator.passwordValidator,
                            suffixIcon: true,
                            obscure: _obscureText,
                            onPressed: _toggle,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormScreen(
                            textEditingController: confirm_passwordController,
                            hinttext: "Confirm New Password",
                            validator: AppValidator.confirm_passwordValidator,
                            suffixIcon: true,
                            obscure: _obscureText1,
                            onPressed: _toggle1,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          !isLoading
                              ? ButtonWidget(
                                  text: 'Confirm',
                                  onTap: () {
                                    setState(() {
                                      _error = '';
                                    });
                                    if (isLoading) {
                                      return;
                                    }

                                    resetPassword(passwordController.text,
                                        confirm_passwordController.text);

                                    // if (isLoading) {
                                    //   return;
                                    // }

                                    // if (_newPasswordController.text.isEmpty ||
                                    //     _newPasswordController.text.length < 6) {
                                    //   DialogHelper.showFlutterToast(
                                    //       strMsg:
                                    //           "Password should be min 6 characters");
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });

                                    //   return;
                                    // }
                                    // if (_confirmpasswordController.text.isEmpty ||
                                    //     _confirmpasswordController.text.length < 6) {
                                    //   DialogHelper.showFlutterToast(
                                    //       strMsg:
                                    //           "Password should be min 6 characters");
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });

                                    //   return;
                                    // }
                                    // resetPassword(
                                    //   _newPasswordController.text,
                                    //   _confirmpasswordController.text,
                                    // );
                                  },
                                )
                              : ButtonWidgetLoader(),
                          SizedBox(height: 45),
                          _isValid
                              ? const Text(
                                  'Set Password Successfully!',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Amazon',
                                    fontSize: 15,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText;
    });
  }

  resetPassword(String newpassword, String confirmpassword) async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirm_passwordController.text) {
        var data = {
          'id': widget.id,
          'password': newpassword,
          'confirm_password': confirmpassword,
          // 'email': widget.email,
        };

        LoginApi registerresponse = LoginApi(data);
        var response = await registerresponse.setnewpassword();

        print(response);

        setState(() {
          isLoading = false;
        });

        if (response['status'].toString() == 'true') {
          setState(() {
            isLoading = false;
          });

          DialogHelper.showFlutterToast(strMsg: "User New Password Updated!!");
          Navigator.pushReplacementNamed(context, Routes.loginallTab);

          // Navigator.pop(context);

        } else {
          DialogHelper.showFlutterToast(
              strMsg: "The password and confirm password must match.");
        }
      } else {
        setState(() {
          _error = "Confirm password must be match";
          isLoading = false;
        });
        DialogHelper.showFlutterToast(strMsg: "Confirm password must be match");
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
