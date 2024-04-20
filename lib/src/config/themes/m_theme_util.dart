
import 'package:flutter/services.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';



class ThemeUtil{
  static void makeSplashTheme(){
    SystemChrome.setSystemUIOverlayStyle(
         const SystemUiOverlayStyle(
            statusBarColor: MyColor.colorPrimary,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: MyColor.colorPrimary,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }
  static void allScreenTheme(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: MyColor.colorWhite,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: MyColor.colorBlack,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }
}


/// for default theme
//
// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
//     updateAppTheme();
//   }
//
//   void updateAppTheme() {
//     final Brightness currentBrightness = AppTheme.currentSystemBrightness;
//     currentBrightness == Brightness.light
//         ? _setTheme(ThemeMode.light)
//         : _setTheme(ThemeMode.dark);
//   }
//
//   void _setTheme(ThemeMode themeMode) {
//     AppTheme.setStatusBarAndNavigationBarColors(themeMode);
//     emit(ThemeState(themeMode: themeMode));
//   }
// }