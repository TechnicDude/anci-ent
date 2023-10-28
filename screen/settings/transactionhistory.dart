import 'package:ancientmysticmusic/main.dart';
import 'package:ancientmysticmusic/provider/PaymenthistoryProvider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/nodatafounderror.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  PaymenthistoryProvider paymenthistoryProvider = PaymenthistoryProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymenthistoryProvider =
        Provider.of<PaymenthistoryProvider>(context, listen: false);
    paymenthistoryProvider.paymenthistorydatalist(MyApp.userid ?? '');

    print("userid ${MyApp.userid}");
    print(MyApp.userid);
    print(MyApp.AUTH_TOKEN_VALUE);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(title: Text("Transaction")),
      body: Consumer<PaymenthistoryProvider>(
          builder: (context, paymenthistoryProvider, child) {
        if (paymenthistoryProvider.paymenthistorydataList.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              ListView.builder(
                  itemCount:
                      paymenthistoryProvider.paymenthistorydataList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 1.h, left: 1.5.h, right: 1.5.h),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(1.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            paymenthistoryProvider
                                                .paymenthistorydataList[index]
                                                .albums!
                                                .title
                                                .toString(),
                                            maxLines: 1,
                                            style: Style_File.title.copyWith(
                                                color: colorPrimary,
                                                fontSize: 16.sp),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Transaction id: ",
                                                style: Style_File.subtitle
                                                    .copyWith(
                                                        color: colorBlack),
                                              ),
                                              Text(
                                                paymenthistoryProvider
                                                    .paymenthistorydataList[
                                                        index]
                                                    .localTransactionId
                                                    .toString(),
                                                style: Style_File.subtitle
                                                    .copyWith(
                                                        color: colorBlack),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "USD: ",
                                                style: Style_File.title
                                                    .copyWith(
                                                        color: colorBlack,
                                                        fontSize: 16.sp),
                                              ),
                                              Text(
                                                "${paymenthistoryProvider.paymenthistorydataList[index].albums!.price.toString() ?? '0'}",
                                                style: Style_File.title
                                                    .copyWith(
                                                        color: Colors.green,
                                                        fontSize: 16.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            paymenthistoryProvider
                                                .paymenthistorydataList[index]
                                                .paymentCreated
                                                .toString(),
                                            style: Style_File.subtitle
                                                .copyWith(color: colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 3.h,
              ),
            ],
          );
        } else {
          return NoDataFoundErrorScreens(
            height: 50.h,
          );
          //   LoaderScreen();
        }
      }),
    );
  }
}
