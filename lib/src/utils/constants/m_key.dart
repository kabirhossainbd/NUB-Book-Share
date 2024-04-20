import 'package:nub_book_sharing/model/response/language_model.dart';

class MyKey {
  static const String theme = 'theme';
  static const String token = 'token';
  static const String savedData = 'savedData';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String setMinAgeRange = 'setMinAgeRange';
  static const String setMaxAgeRange = 'setMaxAgeRange';
  static const String notification = 'all';


  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'Hindi', countryCode: 'IND', languageCode: 'ind'),
  ];
}