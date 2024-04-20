import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {

  int _rechargeIndex = 0;
  int get rechargeIndex => _rechargeIndex;

  setRechargeItem(int index, bool notify){
    _rechargeIndex = index;
    if(notify){
      update();
    }
  }

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  setPayment(int index, bool notify){
    _paymentIndex = index;
    if(notify){
      update();
    }
  }

}
