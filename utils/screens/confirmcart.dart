import 'dart:convert';
import 'dart:developer';

import 'package:ancientmysticmusic/apis/paymentapi.dart';
import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/utils/button_widget.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/screens/carduipayment.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/utils.dart';
import 'package:ancientmysticmusic/utils/webviewscreen.dart';
import 'package:authorize_net_plugin/authorize_net_plugin.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:http/http.dart' as http;

class ConfirmCart extends StatefulWidget {
  final Function? oncallback;
  final String totalprice;
  const ConfirmCart({super.key, required this.totalprice, this.oncallback});

  @override
  State<ConfirmCart> createState() => _ConfirmCartState();
}

class _ConfirmCartState extends State<ConfirmCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: ClayContainer(
        width: 90.w,
        borderRadius: 2.w,
        height: 6.h,
        color: colorSecondry,
        // parentColor: Color,
        // emboss: true,
        spread: 1,
        depth: 25,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total",
                  style: Style_File.subtitle,
                ),
                if (widget.totalprice.toString().trim() != '')
                  if (widget.totalprice.toString().trim() != "null")
                    Text(
                      "\$ ${double.parse(widget.totalprice.toString()).toStringAsFixed(2)}",
                      style: Style_File.subtitle,
                    ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => PaymentCards(
                              amount:
                                  "\$ ${double.parse(widget.totalprice).toStringAsFixed(2)}",
                            )));
                // initPlatformState();
              },
              child: ButtonWidget(
                text: 'Confirm Cart',
                // onTap: () async {
                //   // Navigator.pushNamed(context, Routes.paymentScreen);
                //   // await Utils.makePayment('1');
                //   await makePayment();
                // },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

//   Map<String, dynamic>? paymentIntentData;
//   Future makePayment() async {
//     try {
//       paymentIntentData =
//           await createPaymentIntent('1', 'USD'); //json.decode(response.body);
//       // print('Response body==>${response.body.toString()}');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret:
//                       paymentIntentData!['client_secret'],
//                   // applePay: true,
//                   // googlePay: true,
//                   // testEnv: true,
//                   style: ThemeMode.dark,
//                   // merchantCountryCode: 'US',
//                   merchantDisplayName: 'ANNIE'))
//           .then((value) {});

//       ///now finally display payment sheeet
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       // await Stripe.instance
//       //     .presentPaymentSheet(
//       //         parameters: PresentPaymentSheetParameters(
//       //   clientSecret: paymentIntentData!['client_secret'],
//       //   confirmPayment: true,
//       // ))
//       //     .then((newValue) async {
//       //   print('payment intent' + paymentIntentData!['id'].toString());
//       //   print(
//       //       'payment intent' + paymentIntentData!['client_secret'].toString());
//       //   print('payment intent' + paymentIntentData!['amount'].toString());
//       //   print('payment intent' + paymentIntentData.toString());
//       //   //orderPlaceApi(paymentIntentData!['id'].toString());
//       //   var body = {
//       //     "user_id": MyApp.userid,
//       //     "amount": (paymentIntentData!['amount'] / 100).toString(),
//       //     "payment_method": 'card',
//       //     "status": "success",
//       //     "currency": 'USD',
//       //     "charge_id_or_token": paymentIntentData!['client_secret'].toString(),
//       //     'payer_email': MyApp.email_VALUE,
//       //     "local_transaction_id": paymentIntentData!['id'].toString(),
//       //   };

//       //   PaymentApi paymentApi = PaymentApi(body);
//       //   final response = await paymentApi.paymentstatus();
//       //   print(response);
//       //   widget.oncallback!("ok");

//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //     SnackBar(
//       //       content: Text("Payment successfully"),
//       //     ),
//       //   );

//       //   paymentIntentData = null;
//       // }).onError((error, stackTrace) {
//       //   print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       // });
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       // showDialog(
//       //     context: context,
//       //     builder: (_) => AlertDialog(
//       //           content: Text("Cancelled "),
//       //         ));
//     } catch (e) {
//       print('$e');
//     }
//   }

//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization':
//                 'Bearer sk_test_51Lk677CX1eRrOBKdYm9pkMD6FNM8z3Qt6mz7JpkdAB4uVpzLnTOKJ7skue2n5zJI1ITa4J6XwTRYa327O2QjZn2a00mYjjQd1h',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }

//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
// }