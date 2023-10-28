import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentDoneScreen extends StatefulWidget {
  const PaymentDoneScreen({super.key});

  @override
  State<PaymentDoneScreen> createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(
        title: Text("Payment Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 6.h,
                    child: Icon(
                      Icons.paypal_sharp,
                      color: Colors.red,
                    ),
                  ),
                  //Image.asset(ImageFile.pay)),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "Payment Status",
                    style: Style_File.title.copyWith(fontSize: 16.sp),
                  )
                ],
              ),
              Column(
                children: [
                  Container(height: 30.h, child: Image.asset(ImageFile.pay)),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Payment Successful!",
                    style: Style_File.title.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "You Can find a record added in the transaction history section.",
                    style: Style_File.subtitle.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Total Paid",
                    style: Style_File.title.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "\$ 300",
                    style: Style_File.title.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Go to Your Wallet",
                        style: Style_File.title.copyWith(fontSize: 20.sp),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
