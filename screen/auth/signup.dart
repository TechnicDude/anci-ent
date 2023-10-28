import 'package:ancientmysticmusic/apis/loginapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/screen/auth/login.dart';
import 'package:ancientmysticmusic/utils/app_validator.dart';
import 'package:ancientmysticmusic/utils/button_widget.dart';
import 'package:ancientmysticmusic/utils/buttonwidgetloader.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/socialbutton.dart';
import 'package:ancientmysticmusic/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/stack_bar.dart';
import '../../utils/string_file.dart';
import '../../utils/style_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String email, password, confirm_password;
  bool isLoading = false;

  late ScaffoldMessengerState scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _password = '';
  String _confirmpassword = '';
  String _error = '';
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Register Successfully');
      debugPrint(_userEmail);
      debugPrint(_password);
      debugPrint(_confirmpassword);
    }
  }

  bool _obscureText = true;

  bool _obscureText1 = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();

  bool _isLoggedIn = false;
  Map _userObj = {};
  @override
  void initState() {
    super.initState();
  }

  bool setvalue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height:70.h,
        decoration: BoxDecoration(
          color: colorSecondry,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 2.h, left: 2.0.h, right: 2.0.h),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormScreen(
                      hinttext: 'Email Address',
                      textEditingController: emailController,
                      validator: AppValidator.emailValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormScreen(
                      hinttext: 'Password',
                      textEditingController: passwordController,
                      validator: AppValidator.passwordValidator,
                      suffixIcon: true,
                      obscure: _obscureText,
                      onPressed: _toggle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormScreen(
                      hinttext: 'Confirm Password',
                      textEditingController: confirm_passwordController,
                      validator: AppValidator.confirm_passwordValidator,
                      suffixIcon: true,
                      obscure: _obscureText1,
                      onPressed: _toggle1,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      _error,
                      style: Style_File.subtitle
                          .copyWith(color: Colors.red, fontSize: 15.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    !isLoading
                        ? ButtonWidget(
                            text: 'Sign Up',
                            onTap: () {
                              setState(() {
                                _error = '';
                              });
                              if (isLoading) {
                                return;
                              }

                              signup(
                                  emailController.text,
                                  passwordController.text,
                                  confirm_passwordController.text);
                            },
                          )
                        : ButtonWidgetLoader(),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
      _obscureText1 = !_obscureText1;
    });
  }

  signup(email, password, confirm_password) async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirm_passwordController.text) {
        var data = {
          'email': email,
          'password': password,
          'confirm_password': confirm_password
        };
        LoginApi registerresponse = LoginApi(data);
        var response = await registerresponse.register();
        print(response);
        print(data.toString());
        if (response['status'].toString().toLowerCase() == "true") {
          Map<String, dynamic> user = response['data'];

          Navigator.pushNamed(context, Routes.otpVerify, arguments: {
            StringFile.pagetype: StringFile.signup,
            StringFile.email: email,
          });
          setState(() {
            isLoading = false;
          });

          DialogHelper.showFlutterToast(strMsg: "OTP sent Successful");
        } else {
          setState(() {
            _error = response['error'].toString();
            isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = "Confirm password must be match";
          isLoading = false;
        });
        // DialogHelper.showFlutterToast(strMsg: "Confirm password must be match");
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
