import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ancientmysticmusic/apis/loginapi.dart';
import 'package:ancientmysticmusic/db_helper/dialog_helper.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/input_formatters.dart';
import 'package:ancientmysticmusic/utils/my_strings.dart';
import 'package:ancientmysticmusic/utils/payment_card.dart';
import 'package:authorize_net_plugin/authorize_net_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class PaymentCards extends StatefulWidget {
  final String amount;
  const PaymentCards({
    super.key,
    required this.amount,
  });

  @override
  State<PaymentCards> createState() => _PaymentCardsState();
}

class _PaymentCardsState extends State<PaymentCards> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showpop = false;

  var _formKey = new GlobalKey<FormState>();

  var numberController = new TextEditingController();
  var zipController = new TextEditingController();

  var _paymentCard = PaymentCard();

  var _autoValidateMode = AutovalidateMode.disabled;

  var _card = new PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorSecondry,
        key: _scaffoldKey,
        appBar: new AppBar(
            // title: new Text(widget.title!),
            ),
        body: Stack(
          children: [
            new Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: new Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        // height: 40.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.h)),
                            border: Border.all(color: Colors.white, width: 0.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(1, 2),
                              ),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                new TextFormField(
                                  decoration: const InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    icon: const Icon(
                                      Icons.person,
                                      size: 30.0,
                                    ),
                                    hintText: 'Enter card holder name',
                                    labelText: 'Card holder Name',
                                  ),
                                  onSaved: (String? value) {
                                    _card.name = value;
                                  },
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) =>
                                      value!.isEmpty ? Strings.fieldReq : null,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                new TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(19),
                                    new CardNumberInputFormatter()
                                  ],
                                  controller: numberController,
                                  decoration: new InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    icon: CardUtils.getCardIcon(
                                        _paymentCard.type),
                                    hintText: 'Enter Card Number',
                                    labelText: 'Number',
                                  ),
                                  onSaved: (String? value) {
                                    print('onSaved = $value');
                                    print(
                                        'Num controller has = ${numberController.text}');
                                    _paymentCard.number =
                                        CardUtils.getCleanedNumber(value!);
                                  },
                                  validator: CardUtils.validateCardNum,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                new TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(4),
                                  ],
                                  decoration: new InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    icon: new Image.asset(
                                      'assets/images/card_cvv.png',
                                      width: 30.0,
                                      color: Colors.grey[600],
                                    ),
                                    hintText: 'Number behind the card',
                                    labelText: 'CVV',
                                  ),
                                  validator: CardUtils.validateCVV,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    _paymentCard.cvv = int.parse(value!);
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                new TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(4),
                                    new CardMonthInputFormatter()
                                  ],
                                  decoration: new InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    icon: new Image.asset(
                                      'assets/images/calender.png',
                                      width: 30.0,
                                      color: Colors.grey[600],
                                    ),
                                    hintText: 'MM/YY',
                                    labelText: 'Expiry Date',
                                  ),
                                  validator: CardUtils.validateDate,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    List<int> expiryDate =
                                        CardUtils.getExpiryDate(value!);
                                    _paymentCard.month = expiryDate[0];
                                    _paymentCard.year = expiryDate[1];
                                  },
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                new TextFormField(
                                  controller: zipController,
                                  decoration: new InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    icon: new Image.asset(
                                      'assets/images/calender.png',
                                      width: 30.0,
                                      color: Colors.grey[600],
                                    ),
                                    hintText: 'Enter Zip code',
                                    labelText: 'Zip code',
                                  ),
                                  // validator: CardUtils.validateDate,
                                  keyboardType: TextInputType.number,
                                  // onSaved: (value) {
                                  //   List<int> expiryDate =
                                  //       CardUtils.getExpiryDate(value!);
                                  //   _paymentCard.month = expiryDate[0];
                                  //   _paymentCard.year = expiryDate[1];
                                  // },
                                ),
                                
                                
                                new SizedBox(
                                  height: 50.0,
                                ),
                                new Container(
                                  alignment: Alignment.center,
                                  child: _getPayButton(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            if (showpop)
              Container(
                height: 90.h,
                width: 100.w,
                color: Colors.transparent,
                child: Center(
                    child: Container(
                        height: 10.w,
                        width: 10.w,
                        child: CircularProgressIndicator())),
              )
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  Future<void> _validateInputs() async {
    setState(() {
      showpop = true;
    });
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      setState(() {
        showpop = false;
      });
    } else {
      form.save();
      initPlatformState();
      // Encrypt and send send payment details to payment gateway

    }
  }

  String _authorizeNet = 'Unknown';

  Future<void> initPlatformState() async {
    String authorizeNet;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      authorizeNet = await AuthorizeNetPlugin.authorizeNetToken(
          env: 'production',
          cardNumber: _paymentCard.number.toString(),
          expirationMonth: _paymentCard.month.toString(),
          expirationYear: _paymentCard.year.toString(),
          cardCvv: _paymentCard.cvv.toString(),
          zipCode: zipController.text,
          cardHolderName: _paymentCard.name.toString(),
          apiLoginId: '5kt93MkZ7',
          clientId:
              '62U74ZcXtxZuA9efSU37vYEqKeZL6ttep439RPuWT4YvQuJ3y8fXwSY48DL6qPW9');
      print(authorizeNet);
      log(authorizeNet);
      if (authorizeNet.isNotEmpty) {
        requestpaymentapi(authorizeNet);
      } else {
        setState(() {
          showpop = false;
        });
      }
    } on PlatformException {
      authorizeNet = 'Failed to get platform version.';
      setState(() {
        showpop = false;
      });
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _authorizeNet = authorizeNet;
    });
    print(_authorizeNet);
  }

  Future requestpaymentapi(String authorizeNet) async {
    String amount = widget.amount.replaceAll('\$', "");

    var body = {
      "createTransactionRequest": {
        "merchantAuthentication": {
          "name": "5kt93MkZ7",
          "transactionKey": "3B76v6kS6x8Ck72A"
        },
        "refId": "12367",
        "transactionRequest": {
          "transactionType": "authCaptureTransaction",
          "amount": amount.toString(),
          "payment": {
            "opaqueData": {
              "dataDescriptor": "COMMON.ACCEPT.INAPP.PAYMENT",
              "dataValue": authorizeNet,
            }
          }
        }
      }
    };

    http.Response response = await http.post(
        Uri.parse('https://api.authorize.net/xml/v1/request.api'),
        body: jsonEncode(body));
    print(response.body);
    var status = jsonDecode(response.body);
    if (status['messages']['resultCode'].toString().toLowerCase() == "ok") {
      log("message data");
      var data = {
        "price": amount,
        "user_id": MyApp.userid,
        "status": "success",
        "charge_id_or_token": "0",
        "local_transaction_id": status['transactionResponse']['transId']
      };
      log("message data");
      print(data.toString());
      LoginApi loginApi = LoginApi(data);
      final response = await loginApi.paymentupdate();
      print(response);
      DialogHelper.showFlutterToast(
          strMsg: status['messages']['message'][0]['text']);
      setState(() {
        showpop = false;
      });
      _dialogBuilder(context, status['messages']['message'][0]['text']);

      // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      //     Routes.splashScreen, (Route<dynamic> route) => false);
    } else {
      setState(() {
        showpop = false;
      });
      _dialogBuilder(context, status['messages']['message'][0]['text']);
      DialogHelper.showFlutterToast(
          strMsg: status['messages']['message'][0]['text']);
    }
  }

  Future<void> _dialogBuilder(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        Routes.splashScreen, (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          Strings.pay,
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return InkWell(
          onTap: () {
            _validateInputs();
          },
          child: Container(
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1.h)),
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 65, 251),
                    Color.fromARGB(255, 32, 26, 194),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: Text(
                "${Strings.pay.toString()} ${widget.amount}",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ));
    }
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
}
