import 'package:ancientmysticmusic/utils/buttons_two.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/socialbutton.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Payment")),
        body: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Choose your payment method",
                    style: Style_File.title.copyWith(color: colorBlack),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Credit card / Debit card",
                    style: Style_File.subtitle
                        .copyWith(color: colorBlack, fontSize: 15.sp),
                  ),
                  IconButton(
                    icon: Icon(Icons.credit_card),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Stripe",
                    style: Style_File.subtitle
                        .copyWith(color: colorBlack, fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  IconButton(
                    icon: Icon(Icons.credit_card),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                child: Container(
                  height: 5.h,
                  width: 15.h,
                  color: colorSecondry,
                  child: Center(
                    child: Text(
                      "PAY NOW",
                      style: TextStyle(color: colorWhite, fontSize: 15.sp),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
