import 'dart:convert';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/data/datasource/remote/http_client.dart';
import 'package:nub_book_sharing/src/utils/constants/m_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedRepo {
  final ApiClient apiSource;
  final SharedPreferences sharedPreferences;
  SavedRepo({required this.apiSource, required this.sharedPreferences});


  List<BookModel> getSavedList() {
    List<String>? favourites = [];
    if(sharedPreferences.containsKey(MyKey.savedData)) {
      favourites = sharedPreferences.getStringList(MyKey.savedData);
    }
    List<BookModel> favouriteList = [];
    favourites?.forEach((fav) => favouriteList.add(BookModel.fromJson(jsonDecode(fav))) );
    return favouriteList;
  }

  void addToSavedList(List<BookModel> fevProductList) {
    List<String> favourites = [];
    for (var fevModel in fevProductList) {
      favourites.add(jsonEncode(fevModel.toJson()));
    }
    sharedPreferences.setStringList(MyKey.savedData, favourites);
  }


}