import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/apis/network.dart';

class LoginApi {
  final Map<String, dynamic> body;

  LoginApi(this.body);

  Future register() async {
    Service service = new Service(APIURL.REGISTRATION, body);
    var data = await service.formdata();
    return data;
  }

  // Future verify() async {
  //   Service service = new Service(VERIFY, body);
  //   var data = await service.formdata();
  //   return data;
  // }

  Future login() async {
    Service service = new Service(APIURL.LOGIN, body);
    var data = await service.formdata();
    return data;
  }

  Future verifyOtp() async {
    Service service = new Service(APIURL.VERIFYOTP, body);
    var data = await service.formdata();

    return data;
  }

  Future forgetverifyOtp() async {
    Service service = new Service(APIURL.FORGETVERIFYOTP, body);
    var data = await service.formdata();

    return data;
  }

  Future forgetpassword() async {
    Service service = new Service(APIURL.FORGETPASSWORD, body);
    var data = await service.formdata();

    return data;
  }

  // Future resetpassword() async {
  //   Service service = new Service(RESETPASSWORD, body);
  //   var data = await service.formdata();

  //   return data;
  // }

  Future setnewpassword() async {
    Service service = Service(APIURL.SETNEWPASSWORD, body);
    var data = await service.formdata();

    return data;
  }

  Future updateprofile() async {
    Service service = new Service(APIURL.ProfileUpdate, body);
    var data = await service.formdata();

    return data;
  }

  Future fcmregister() async {
    Service service = new Service(APIURL.fcmregister, body);
    var data = await service.formdata();
    return data;
  }

  Future socialregister() async {
    Service service = new Service(APIURL.Socialregister, body);
    var data = await service.formdata();
    return data;
  }

  Future paymentupdate() async {
    Service service = new Service(APIURL.payment, body);
    var data = await service.formdata();
    return data;
  }
}
