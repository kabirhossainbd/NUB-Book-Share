import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nub_book_sharing/model/repo/save_repo.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';

class SavedController extends GetxController implements GetxService {
  final SavedRepo savedRepo;
  SavedController({required this.savedRepo});


  List<BookModel> _savedList = [];
  List<BookModel> get savedList => _savedList;

  List<String> _savedIdList = [];
  List<String> get savedIdList => _savedIdList;

  int _favouriteListIndex = 0;
  int get favouriteListIndex => _favouriteListIndex;

  void setFavouriteListIndex(int index) {
    _favouriteListIndex = index;
    update();
  }

  void addSavedList(BookModel bookModel) async {
    _savedList.add(bookModel);
    _savedIdList.add(bookModel.id ?? '0');
    savedRepo.addToSavedList(_savedList);
    debugPrint('-----------------------::::::${bookModel.id}');
    myToast('Saved successfully');
    update();
  }

  void removeSavedList(BookModel bookModel) {
    int idIndex = _savedIdList.indexOf(bookModel.id ?? '0');
    _savedIdList.removeAt(idIndex);
    _savedList.removeAt(idIndex);
    savedRepo.addToSavedList(_savedList);
     myToast('Remove from bookmark');
    update();
  }


  Future<void> initSavedList() async {
    _savedList = [];
    _savedIdList = [];
    _savedList.addAll(savedRepo.getSavedList());
    for(int index = 0; _savedList.length > index ; index ++){
      _savedIdList.add(_savedList[index].id ?? '0');
    }
  }

  void removeSaved() {
    _savedList = [];
    savedRepo.addToSavedList(_savedList);
    update();
  }


  bool _isList = true;
  bool get isList => _isList;

  void setList(){
    _isList = !_isList;
    update();
  }

  setIsList(bool value){
    _isList = value;
    update();
  }

  int _indicatorIndex = 0;
  int get indicatorIndex => _indicatorIndex;

  void setIndicator(int index){
    _indicatorIndex = index;
    update();
  }

  int _filterIndex = 0;
  int get filterIndex => _filterIndex;



/*  void sortSearchList() {
    if (_filterIndex == 0) {
      _favouriteList.sort((product1, product2) => DateTime.parse(product1.createdAt!).compareTo(DateTime.parse(product2.createdAt!)));
      Iterable<Data> iterable =  _favouriteList.reversed;
      _favouriteList = iterable.toList();
    } else if (_filterIndex == 1) {
      _favouriteList.sort((product1, product2) => product1.sellingPrice!.compareTo(product2.sellingPrice!));
    } else if (_filterIndex == 2) {
      _favouriteList.sort((product1, product2) => product1.sellingPrice!.compareTo(product2.sellingPrice!));
      Iterable<Data> iterable =  _favouriteList.reversed;
      _favouriteList = iterable.toList();
    } else if (_filterIndex == 3) {
      _favouriteList.sort((product1, product2) => product1.odometer!.compareTo(product2.odometer!));
    } else if (_filterIndex == 4) {
      _favouriteList.sort((product1, product2) => product1.odometer!.compareTo(product2.odometer!));
      Iterable<Data> iterable =  _favouriteList.reversed;
      _favouriteList = iterable.toList();
    }else if (_filterIndex == 5) {
      _favouriteList.sort((product1, product2) => product1.firstRegistration!.toLowerCase().compareTo(product2.firstRegistration!.toLowerCase()));
    } else if (_filterIndex == 6) {
      _favouriteList.sort((product1, product2) => product1.firstRegistration!.toLowerCase().compareTo(product2.firstRegistration!.toLowerCase()));
      Iterable<Data> iterable =  _favouriteList.reversed;
      _favouriteList = iterable.toList();
    }
    _favouriteIdList = [];
    for(int inx = 0; inx < _favouriteList.length; inx ++ ){
      _favouriteIdList.add(_favouriteList[inx].carId!);
    }
    update();
  }*/

  setFilterIndex(int index) async {
    _filterIndex = index;
    update();
  }


}