import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/edit_profile.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (profile) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: MyColor.getSecondaryColor().withOpacity(0.8),
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: MyColor.getSecondaryColor().withOpacity(0.2),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -60,
                    child: GestureDetector(
                      onTap: ()=>  Navigator.push(context, CupertinoPageRoute(builder: (_) => EditProfileScreen(user: APIs.me))).then((value) => setState(() {})),
                      child: Stack( alignment: Alignment.topRight, clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColor.colorWhite, width: 5),
                              borderRadius: BorderRadius.circular(16),
                              color: MyColor.getSecondaryColor()
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  imageUrl: APIs.me.profile ?? '',
                                  placeholder: (url, error) => const Icon(CupertinoIcons.person, size: 40,),
                                  errorWidget: (context, url, error) => const Icon(CupertinoIcons.person, size: 40,),
                                )),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColor.getBackgroundColor()
                              ),
                              child: Icon(Icons.edit, size: 16, color: MyColor.getSecondaryColor(),),
                            ),
                          ) ,
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,16,12),
                    child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('1k', style: robotoRegular.copyWith(color: MyColor.getSecondaryColor(), fontSize: MySizes.fontSizeDefault),),
                           const SizedBox(height: 2),
                            Text('Complete Task', style: robotoRegular.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeSmall),),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('120', style: robotoRegular.copyWith(color: MyColor.getSecondaryColor(), fontSize: MySizes.fontSizeDefault),),
                            const SizedBox(height: 2),
                            Text('Ongoing Task', style: robotoRegular.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeSmall),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.size.height * 0.1),
            Column(
              children: [
                Text(APIs.me.name  ?? APIs.me.email ?? '', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge)),
               const SizedBox(height: 2),
                Text(APIs.me.about ?? '', style: robotoRegular.copyWith(color: MyColor.getGreyColor(), fontSize: MySizes.fontSizeDefault)),
                const SizedBox(height: 12),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 17),
                  padding: const EdgeInsets.fromLTRB(16,24,16,24),
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFA39AFF).withOpacity(0.9),
                            const Color(0xFFA39AFF).withOpacity(0.65),
                            const Color(0xFFA39AFF).withOpacity(0.3),
                          ]
                      )
                  ),
                  child: Row( crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your are doing Great!', style: robotoExtraBold.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeExtraLarge)),
                            const SizedBox(height: 5),
                            Text('21 task complete in a row', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeSmall)),
                          ],
                        ),
                      ),

                      const Icon(CupertinoIcons.gift, size: 50,),
                      const SizedBox(width: 10),

                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // _customItem(Icons.book, 'Reading Book', 'Upload pdf and reading book', const Color(0xFFE7E5F2), onTap: (){
                //   pickPDFText();
                // }),
                _customItem(Icons.my_location_outlined, 'Location', 'Road 01,House 10, Dhaka', const Color(0xFFE7E5F2), onTap: (){}),
                _customItem(Icons.alternate_email, 'Email', 'demo@exampl.com', const Color(0xFFFEEFE7), onTap: (){}),
                _customItem(Icons.dark_mode, 'Theme', 'Light', const Color(0xFFEFF9F8), onTap: (){}),
                _customItem(Icons.logout, 'Log Out', '', const Color(0xFFEFF9F8), onTap: ()=> _customLogout(profile),),

              ],
            ),

          ],
        ),

      ),
    );
  }


  _customItem(IconData icon, String title, String value,Color bgColor, {VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor
        ),
        child: Row(
          children: [
           Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: MyColor.getBackgroundColor()
             ),
             child: Icon(icon, size: 20, color: MyColor.getSecondaryColor(),),
           ) ,
            const SizedBox(width: 12,),
            Expanded(
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: robotoExtraBold.copyWith(color: MyColor.getSecondaryColor(), fontSize: MySizes.fontSizeExtraLarge)),
                    if(value.isNotEmpty)...[
                      Text(value, style: robotoRegular.copyWith(color: const Color(0xFFB3B2B7), fontSize: MySizes.fontSizeDefault)),
                    ]
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }


  void _customLogout(AuthController auth) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  alignment: Alignment.center,
                  backgroundColor: MyColor.getBackgroundColor(),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () => Get.back(),
                                child: Text('cancel'.tr,
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorGrey,
                                      fontSize:
                                      MySizes.fontSizeDefault),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                            const SizedBox(width: 50,),
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: ()=> auth.logOut(),
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF54336),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "log_out".tr,
                                    style: robotoRegular.copyWith(
                                        color: MyColor.colorWhite,
                                        fontSize:
                                        MySizes.fontSizeDefault),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                            )
                          ]),
                    )
                  ],
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text('log_out'.tr, style: robotoLight.copyWith(
                      color: MyColor.getTextColor(),
                      fontSize: 28),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  content:  Text( 'are_you_sure_want'.tr,
                    style: robotoLight.copyWith(
                        color: MyColor.getTextColor(),
                        fontSize:
                        MySizes.fontSizeLarge),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }


  // /// Picks a new PDF document from the device
  // Future pickPDFText() async {
  //   var filePickerResult = await FilePicker.platform.pickFiles();
  //   if (filePickerResult != null) {
  //     Get.to(PDFViewer(pdfPath: filePickerResult.files.single.path!));
  //      setState(() {});
  //   }
  // }
}
