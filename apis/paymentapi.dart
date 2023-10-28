import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';

class PaymentApi {
  final Map<String, dynamic> body;
  PaymentApi(this.body);

  Future addToCart() async {
    Service service = new Service(APIURL.AddToCart, body);
    var data = await service.formdata();
    return data;
  }

  Future removeToCart() async {
    Service service = new Service(APIURL.RemoveCart, body);
    var data = await service.formdata();
    return data;
  }

  Future cartList() async {
    Service service = new Service(APIURL.CartList, body);
    var data = await service.formdata();
    return data;
  }

  Future paymentstatus() async {
    Service service = new Service(APIURL.Paymentstatus, body);
    var data = await service.formdata();
    return data;
  }
}
