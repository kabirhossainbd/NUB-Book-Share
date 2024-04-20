import 'package:get/get.dart';

class EmailMakerController extends GetxController implements GetxService {

  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;

  void toggleSearchActive() {
    _isSearchActive = !_isSearchActive;
    update();
  }

  void setSearchActive(bool value, notify) {
    _isSearchActive = value;
    if(notify){
      update();
    }
  }



  String? _programName;
  String? get programName => _programName;

  setProgramName(String? name){
    _programName = name;
    update();
  }


  int _itemIndex = 0;
  int get itemIndex => _itemIndex;

  setItemIndex(int index, bool notify){
    _itemIndex = index;
    if(notify){
      update();
    }
  }


  int _scriptTypeIndex = 0;
  int get scriptTypeIndex => _scriptTypeIndex;

  setScriptType(int index, bool notify){
    _scriptTypeIndex = index;
    if(notify){
      update();
    }
  }

}
