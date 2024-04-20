import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/localization_controller.dart';
import 'package:nub_book_sharing/controller/splash_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/drawer_dashboard.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';



class LanguageScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;
  const LanguageScreen({super.key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(
      builder: (local) => GetBuilder<SplashController>(
        builder: (onBoard) => Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          body: SafeArea(
            child:  Padding(
              padding: const EdgeInsets.all(MySizes.paddingSizeDefault),
              child: Column(
                children: [
                  const SizedBox(height: MySizes.paddingSizeDefault),
                  Text('HarvestHub Agro', style: robotoBold.copyWith(fontSize: 36,color:  MyColor.getPrimaryColor())),
                  const SizedBox(height: MySizes.paddingSizeExtraSmall),
                  Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Enriching', style: robotoLight.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeLarge),),
                      const SizedBox(width: 8,),
                      Text('Agriculture', style: robotoLight.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeLarge),),
                    ],
                  ),

                  const SizedBox(height: MySizes.paddingSizeDefault),
                  Align(child: Image.asset(MyImage.profile,height: 250,fit: BoxFit.scaleDown)),

                  const SizedBox(height: MySizes.paddingSizeDefault),
                  Text('your_language_preference'.tr, style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                   const SizedBox(height: MySizes.paddingSizeDefault,),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: local.toggleLanguage,
                          child: Container(
                            height: 150,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                              margin: const EdgeInsets.fromLTRB(0,0,8,0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: local.locale.languageCode == 'en' ? MyColor.getPrimaryColor() : MyColor.getSurfaceColor(),
                                boxShadow: [BoxShadow(
                                    color: MyColor.getGreyColor().withOpacity(0.2),
                                    blurRadius: 0.1,
                                    spreadRadius: 0.2,
                                    offset: const Offset(0,1)
                                )],
                              ),
                              child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: local.locale.languageCode == 'en' ? MyColor.getSurfaceColor() : MyColor.getPrimaryColor(),
                                    ),
                                    child: Text('E', style: robotoRegular.copyWith(color: local.locale.languageCode == 'en' ? MyColor.getPrimaryColor() : MyColor.getSurfaceColor(), fontSize: MySizes.fontSizeExtraLarge)),
                                  ),
                                  const SizedBox(height: MySizes.paddingSizeDefault),
                                  Text('English', style: robotoRegular.copyWith(color: local.locale.languageCode == 'en' ? MyColor.getSurfaceColor() : MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeDefault),)
                                ],
                              )
                          ),
                        ),
                      ),
                      const SizedBox(width: MySizes.paddingSizeSmall),
                      Expanded(
                        child: InkWell(
                          onTap: local.toggleLanguage,
                          child: Container(
                              height: 150,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                              margin: const EdgeInsets.fromLTRB(0,0,8,0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: local.locale.languageCode == 'ind' ? MyColor.getPrimaryColor() : MyColor.getSurfaceColor(),
                                boxShadow: [BoxShadow(
                                    color: MyColor.getGreyColor().withOpacity(0.2),
                                    blurRadius: 0.1,
                                    spreadRadius: 0.2,
                                    offset: const Offset(0,1)
                                )],
                              ),
                              child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: local.locale.languageCode == 'ind' ? MyColor.getSurfaceColor() : MyColor.getPrimaryColor(),
                                    ),
                                    child: Text('H', style: robotoRegular.copyWith(color: local.locale.languageCode == 'ind' ? MyColor.getPrimaryColor() : MyColor.getSurfaceColor(), fontSize: MySizes.fontSizeExtraLarge)),
                                  ),
                                  const SizedBox(height: MySizes.paddingSizeDefault),
                                  Text('Hindi', style: robotoRegular.copyWith(color: local.locale.languageCode == 'ind' ? MyColor.getSurfaceColor() : MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeDefault),)
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: MySizes.paddingSizeExtraLarge),
                  CustomButton(text: 'Select Language', onTap: (){
                    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_)=> const DashboardScreen()), (route) => false);
                  }),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
