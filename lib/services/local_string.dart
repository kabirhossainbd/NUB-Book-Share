import 'package:get/get.dart';

class LocaleString extends Translations {
  final Map<String, Map<String, String>> localString;
  LocaleString({required this.localString});

  @override
  Map<String, Map<String, String>> get keys {
    return localString;
  }
}