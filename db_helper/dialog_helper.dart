import 'package:fluttertoast/fluttertoast.dart';

class DialogHelper {
  static void hideLoading() {}

  // if(Get.isDialogOpen!){
  //   Get.back();
  // }

  static Future<void> showFlutterToast({required String strMsg}) async {
    await Fluttertoast.showToast(msg: strMsg);
  }
}
