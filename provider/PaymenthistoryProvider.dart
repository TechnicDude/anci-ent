import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';
import 'package:ancientmysticmusic/model/PaymenthistoryModel.dart';
import 'package:flutter/material.dart';

class PaymenthistoryProvider extends ChangeNotifier {
  PaymenthistoryModel paymenthistoryModel = PaymenthistoryModel();

  List<PaymenthistoryData> _paymenthistorydatalist = [];
  List<PaymenthistoryData> get paymenthistorydataList =>
      _paymenthistorydatalist;

  bool datanotfound = false;

  Future paymenthistorydatalist(String email) async {
    var data = {
      'user_id': email,
    };
    Service _service = new Service(APIURL.PaymentHistory, data);
    final response = await _service.formdata();

    _paymenthistorydatalist = [];
    paymenthistoryModel = PaymenthistoryModel.fromJson(response);

    if (paymenthistoryModel.data != null) {
      if (paymenthistoryModel.data!.length > 0) {
        print(paymenthistoryModel.data!.length);

        for (int i = 0; i < paymenthistoryModel.data!.length; i++) {
          _paymenthistorydatalist.add(paymenthistoryModel.data![i]);
        }
      }
    }

    notifyListeners();
    return;
  }
}
