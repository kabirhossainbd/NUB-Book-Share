import 'package:get/get.dart';

class PasswordController extends GetxController implements GetxService {


  int _passwordTypeIndex = 0;
  int get passwordTypeIndex => _passwordTypeIndex;

  setPasswordType(int index, bool notify){
    _passwordTypeIndex = index;
    if(notify){
      update();
    }
  }



  int _passwordStrengthIndex = 0;
  int get passwordStrengthIndex => _passwordStrengthIndex;

  setPasswordStrength(int index, bool notify){
    _passwordStrengthIndex = index;
    if(notify){
      update();
    }
  }


}
