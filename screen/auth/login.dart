import 'dart:io';

import 'package:ancientmysticmusic/screen/auth/forgetpassword.dart';
import 'package:ancientmysticmusic/screen/home/home.dart';
import 'package:ancientmysticmusic/utils/app_validator.dart';
import 'package:ancientmysticmusic/utils/buttonwidgetloader.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/loader.dart';
import 'package:ancientmysticmusic/utils/socialbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/loginapi.dart';
import '../../db_helper/dialog_helper.dart';
import '../../main.dart';
import '../../page_routes/routes.dart';
import '../../utils/button_widget.dart';
import '../../utils/colors.dart';
import '../../utils/stack_bar.dart';
import '../../utils/string_file.dart';
import '../../utils/style_file.dart';
import '../../utils/textform.dart';

GoogleSignIn googleSignIn = Platform.isIOS
    ? GoogleSignIn(
        // clientId:
        //     '271984837864-njs959jh42m4blc8q9ea6gcifik6f4e0.apps.googleusercontent.com',
        // Optional clientId
        // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
        clientId:
            '867652696529-umcf06pkmme3tooapcfj8cn75coj6cvv.apps.googleusercontent.com',
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      )
    : GoogleSignIn(
        // clientId:
        //     '271984837864-njs959jh42m4blc8q9ea6gcifik6f4e0.apps.googleusercontent.com',
        // Optional clientId
        // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',

        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _password = '';
  String _error = '';
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoggedIn = false;
  Map _userObj = {};
  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print(account);
      setState(() {
        _currentUser = account;
        googlelogin(_currentUser);
      });
    });
    googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        print(account);
        setState(() {
          _currentUser = account;
        });
      });

      // _buildBody();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();
  bool setvalue = false;
  facebooklogin() async {
    if (_userObj["email"] != null) {
      var data = {
        'first_name': _userObj["name"],
        'email': _userObj["email"],
        'facebook_id': _userObj["id"],
        'google_id': "",
      };
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.socialregister();
      print(response);
      if (response['status'] == 'true') {
        Map<String, dynamic> res = response['data'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        MyApp.userid = res['id'].toString();
        MyApp.email_VALUE = res['email'].toString();
        // MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
        sharedPreferences.setString(StringFile.userid, res['id'].toString());
        sharedPreferences.setString(StringFile.email, res['email'].toString());

        Navigator.pushNamedAndRemoveUntil(
            context, Routes.bottomNav, (route) => false);
        // sharedPreferences.setString(
        //     StringFile.authtoken, response['token'].toString());
      } else {
        DialogHelper.showFlutterToast(strMsg: response['error']);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      DialogHelper.showFlutterToast(
          strMsg:
              "Veuillez vous connecter à un autre compte avec un compte Facebook enregistré avec un identifiant de messagerie uniquement");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: colorSecondry,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.h, left: 2.0.h, right: 2.0.h),
          child: Column(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Email
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
                    ],
                  )),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Text("Forget Password?",
                            style: Style_File.subtitle),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()),
                          )
                        },
                      ),
                    ],
                  ),
                ],
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
                      text: 'Sign In',
                      onTap: () {
                        setState(() {
                          _error = '';
                        });
                        if (isLoading) {
                          return;
                        }

                        login(emailController.text, passwordController.text);
                      },
                    )
                  : ButtonWidgetLoader(),
              //: const LoaderScreens(),

              SizedBox(
                height: 5.h,
              ),
              Text(
                "--------------------------Or Continue with--------------------------",
                style: Style_File.subtitle,
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialButton(
                    image: ImageFile.google,
                    text: 'Google',
                    onPressed: () {
                      print("object");
                      print(_currentUser);
                      if (_currentUser != null) {
                        print("object");
                        _handleSignOut();
                      }
                      _handleSignIn();
                    },
                  ),
                  SocialButton(
                    image: ImageFile.fb,
                    text: 'Facebook',
                    onPressed: () async {
                      if (_userObj.isNotEmpty) {
                        await FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                            _userObj = {};
                          });
                        });
                      }

                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance.getUserData().then((userData) {
                          setState(() {
                            _isLoggedIn = true;
                            _userObj = userData;
                            print(userData);
                            facebooklogin();
                          });
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
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

  googlelogin(GoogleSignInAccount? users) async {
    final GoogleSignInAccount? user = users;
    print(user);
    if (user != null) {
      var data = {
        'first_name': user.displayName,
        'email': user.email,
        'facebook_id': "",
        'google_id': user.id,
      };

      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.socialregister();

      if (response['status'] == 'true') {
        print("object data");
        Map<String, dynamic> res = response['data'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        MyApp.userid = res['id'].toString();
        MyApp.email_VALUE = res['email'].toString();
        // MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
        sharedPreferences.setString(StringFile.userid, res['id'].toString());
        sharedPreferences.setString(StringFile.email, res['email'].toString());
        String? token;
        try {
          token = (await FirebaseMessaging.instance.getToken())!;
          print(token);
        } catch (e) {
          print(e);
        }
        var data = {
          "id": res['id'].toString(),
          "token": token,
        };

        LoginApi fcmregisterresponse = LoginApi(data);
        final fcmresponse = await fcmregisterresponse.fcmregister();
        if (fcmresponse['status'].toString().toLowerCase() == 'true') {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.bottomNav, (route) => false);
          sharedPreferences.setString(
              StringFile.authtoken, response['token'].toString());
        }
      } else if (response['error'] ==
          "User already registered!! Please login") {
        print("object");
        sociallogin(user.email, "123456", user.displayName);
      }
    }
  }

  sociallogin(email, password, name) async {
    setState(() {
      isLoading = true;
    });

    var data = {'email': email, 'password': password, "first_name": name};
    print(data.toString());
    LoginApi registerresponse = LoginApi(data);
    final response = await registerresponse.login();
    if (response['status'].toString().toLowerCase() == "true") {
      Map<String, dynamic> res = response['data'];
      String? token;
      try {
        token = (await FirebaseMessaging.instance.getToken())!;
        print(token);
      } catch (e) {
        print(e);
      }
      var data = {
        "id": res['id'].toString(),
        "token": token,
      };

      LoginApi fcmregisterresponse = LoginApi(data);
      final fcmresponse = await fcmregisterresponse.fcmregister();
      print(fcmresponse);
      if (fcmresponse['status'].toString().toLowerCase() == 'true') {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        MyApp.userid = res['id'].toString();
        MyApp.email_VALUE = res['email'].toString();
        MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
        sharedPreferences.setString(StringFile.userid, res['id'].toString());
        sharedPreferences.setString(StringFile.email, res['email'].toString());
        sharedPreferences.setString(
            StringFile.authtoken, response['token'].toString());
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.bottomNav, (route) => false);
        DialogHelper.showFlutterToast(strMsg: "Login Successful");
      }
    } else {
      setState(() {
        _error = response['error'].toString();
        isLoading = false;
      });
    }
  }

  login(email, password) async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      var data = {'email': email, 'password': password};
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.login();
      if (response['status'].toString().toLowerCase() == "true") {
        Map<String, dynamic> res = response['data'];
        String? token;
        try {
          token = (await FirebaseMessaging.instance.getToken())!;
          print(token);
        } catch (e) {
          print(e);
        }
        var data = {
          "id": res['id'].toString(),
          "token": token,
        };

        LoginApi fcmregisterresponse = LoginApi(data);
        final fcmresponse = await fcmregisterresponse.fcmregister();
        print(fcmresponse);
        if (fcmresponse['status'].toString().toLowerCase() == 'true') {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          MyApp.userid = res['id'].toString();
          MyApp.email_VALUE = res['email'].toString();
          MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
          sharedPreferences.setString(StringFile.userid, res['id'].toString());
          sharedPreferences.setString(
              StringFile.email, res['email'].toString());
          sharedPreferences.setString(
              StringFile.authtoken, response['token'].toString());
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.bottomNav, (route) => false);
          DialogHelper.showFlutterToast(strMsg: "Login Successful");
        }
      } else {
        setState(() {
          _error = response['error'].toString();
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
