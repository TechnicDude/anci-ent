import 'package:ancientmysticmusic/page_routes/routes.dart';
import 'package:ancientmysticmusic/screen/settings/Paymentdone.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:ancientmysticmusic/utils/webviewscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondry,
      appBar: AppBar(title: Text("Transaction History")),
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
                      Icons.history_edu_outlined,
                      color: Colors.red,
                    ),
                  ),
                  //Image.asset(ImageFile.logo)),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "Payment",
                    style: Style_File.title.copyWith(fontSize: 18.sp),
                  )
                ],
              ),
              // SizedBox(
              //   height: 4.h,
              // ),
              // Center(
              //     child: Text(
              //   "Total Transaction History",
              //   style: Style_File.title.copyWith(fontSize: 20.sp),
              // )),
              // SizedBox(
              //   height: 2.h,
              // ),
              // Center(
              //     child: Text(
              //   "View all the Transaction you made through using paypal.",
              //   style: Style_File.subtitle.copyWith(fontSize: 14.sp),
              // )),
              SizedBox(
                height: 2.h,
              ),

              // ListView.builder(
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.vertical,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           Container(
              //             height: 5.h,
              //             width: 10.w,
              //             decoration: BoxDecoration(
              //               //color: Colors.white,
              //               borderRadius: BorderRadius.circular(5.w),
              //               border: Border.all(color: Colors.red),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "All",
              //                 style:
              //                     Style_File.subtitle.copyWith(fontSize: 14.sp),
              //               ),
              //             ),
              //           ),
              //           // Container(
              //           //   height: 4.h,
              //           //   width: 20.w,
              //           //   decoration: BoxDecoration(
              //           //     borderRadius: BorderRadius.circular(5.w),
              //           //     border: Border.all(color: Colors.red),
              //           //   ),
              //           //   child: Center(
              //           //     child: Text(
              //           //       "Sort By",
              //           //       style:
              //           //           Style_File.subtitle.copyWith(fontSize: 14.sp),
              //           //     ),
              //           //   ),
              //           // ),
              //           // Container(
              //           //   height: 4.h,
              //           //   width: 20.w,
              //           //   decoration: BoxDecoration(
              //           //     borderRadius: BorderRadius.circular(5.w),
              //           //     border: Border.all(color: Colors.red),
              //           //   ),
              //           //   child: Center(
              //           //     child: Text(
              //           //       "Currency",
              //           //       style:
              //           //           Style_File.subtitle.copyWith(fontSize: 14.sp),
              //           //     ),
              //           //   ),
              //           // ),
              //         ],
              //       );
              //     }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       height: 4.h,
              //       width: 20.w,
              //       decoration: BoxDecoration(
              //         //color: Colors.white,
              //         borderRadius: BorderRadius.circular(5.w),
              //         border: Border.all(color: Colors.red),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "All",
              //           style: Style_File.subtitle.copyWith(fontSize: 14.sp),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 4.h,
              //       width: 20.w,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5.w),
              //         border: Border.all(color: Colors.red),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "Sort By",
              //           style: Style_File.subtitle.copyWith(fontSize: 14.sp),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 4.h,
              //       width: 20.w,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5.w),
              //         border: Border.all(color: Colors.red),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "Currency",
              //           style: Style_File.subtitle.copyWith(fontSize: 14.sp),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, Routes.payScreen);
                }),
                child: ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 8.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(0.5.h),
                                  child: InkWell(
                                    onTap: (() {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  // ChangeNotifierProvider<PrivacyProvider>(
                                                  //   create: (BuildContext context) =>
                                                  //       PrivacyProvider(),
                                                  //   child: PrivacyPolicy(
                                                  //       //  con: con,
                                                  //       // albumdata: albumdata![index],
                                                  //       ),
                                                  // )
                                                  // PaymentDoneScreen()));
                                                  PayScreen()));
                                    }),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Jan 2, 2023 14:54",
                                              style:
                                                  Style_File.subtitle.copyWith(
                                                color: colorGrey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Text(
                                              "Starbucket coffre ",
                                              style:
                                                  Style_File.subtitle.copyWith(
                                                color: colorBlack,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            Text(
                                              "Personal Card",
                                              style:
                                                  Style_File.subtitle.copyWith(
                                                color: colorBlack,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "\$ 18,000",
                                          style: Style_File.subtitle.copyWith(
                                            color: Colors.green,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
