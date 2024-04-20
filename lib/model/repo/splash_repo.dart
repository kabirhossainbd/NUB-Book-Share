import 'package:nub_book_sharing/src/data/datasource/remote/http_client.dart';
import 'package:nub_book_sharing/src/utils/constants/m_key.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashRequest {
  final ApiClient apiSource;
  final SharedPreferences sharedPreferences;
  SplashRequest({required this.apiSource, required this.sharedPreferences});

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(MyKey.theme)) {
      return sharedPreferences.setBool(MyKey.theme, false);
    }
    if(!sharedPreferences.containsKey(MyKey.countryCode)) {
      return sharedPreferences.setString(MyKey.countryCode, 'DE');
    }
    if(!sharedPreferences.containsKey(MyKey.languageCode)) {
      return sharedPreferences.setString(MyKey.languageCode, 'de');
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
