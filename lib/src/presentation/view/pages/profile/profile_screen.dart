import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/model/response/overview_model.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/edit_profile.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/pages/download_books_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/pages/recently_read_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/pages/save_item_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/pages/upload_history_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProfileScreen extends StatefulWidget {
  final bool fromOthers;
  const ProfileScreen({super.key, this.fromOthers = true});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final List<OverviewModel> _overviewList = [
    OverviewModel(id: 0, icon: MyImage.book, name: 'Upload History',itemCount: 210),
    OverviewModel(id: 1, icon: MyImage.saveItem, name: 'Saved Items',itemCount: 20),
    OverviewModel(id: 2, icon: MyImage.openBook, name: 'Recently Read',itemCount: 310),
    OverviewModel(id: 3, icon: MyImage.download, name: 'Download Books',itemCount: 10),
  ];

  @override
  void initState() {
    Get.find<BookController>().getUserBook();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedController>(
      builder: (saved) => GetBuilder<AuthController>(
        builder: (auth) => GetBuilder<BookController>(
          builder: (book) => Scaffold(
            backgroundColor: MyColor.getBackgroundColor(),
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16,20,16,0),
                    child: Row(
                      children: [
                        ProfileAvatar(url: APIs.me.profile ?? ""),
                        const SizedBox(width: 8),
                        Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(APIs.me.name ?? "", style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge), maxLines: 1,),
                            const SizedBox(height: 2),
                            Text(APIs.me.email ?? "", style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                          ],
                        )),
                        const SizedBox(width: 8),
                        GestureDetector(
                            onTap: ()=> Navigator.push(context, PageTransition(child: EditProfileScreen(user: APIs.me), type: PageTransitionType.rightToLeft)).then((value) =>  setState(() {})),
                            child: SvgPicture.asset(MyImage.edit, height: 24,width: 24,))
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Overview', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                  ),
                  const SizedBox(height: 4),

                  /// for category Item
                  StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _overviewList.length,
                      itemBuilder: (_,index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, PageTransition(child: _screens[index], type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: MyColor.getCardColor(),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColor.getGreyColor().withOpacity(0.1),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(2, 2),
                                  ), BoxShadow(
                                    color: MyColor.getGreyColor().withOpacity(0.1),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: const Offset(-1, -1),
                                  )
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(_overviewList[index].icon ?? '', height: 20, width: 20),
                                const SizedBox(height: 8),
                                Text(_overviewList[index].name ?? '',
                                    style: robotoLight.copyWith(color: MyColor
                                        .getTextColor(),
                                        fontSize: MySizes.fontSizeLarge)),
                                const SizedBox(height: 2),
                                Text('${index == 0 ? book.totalUserBooksSize : index == 1 ? saved.savedList.length : 0} item',
                                    style: robotoRegular.copyWith(color: MyColor
                                        .getSecondaryColor(),
                                        fontSize: MySizes.fontSizeSmall)),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),



                  const SizedBox(height: 33),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Activity', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                  ),

                  const SizedBox(height: 12),
                  GetBuilder<HomeController>(
                    builder: (home) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      margin: const EdgeInsets.fromLTRB(16,4,16,8),
                      decoration: BoxDecoration(
                        color: MyColor.getSecondaryColor().withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.bell,),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Notification setting', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeLarge))),
                          Switch(
                            value: home.isNotifications,
                            onChanged: (bool isActive) => home.toggleNotification(),
                            activeColor: MyColor.getPrimaryColor(),
                            inactiveThumbColor: MyColor.getGreyColor(),
                            inactiveTrackColor: MyColor.getGreyColor().withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=> _customLogout(auth),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.fromLTRB(16,4,16,8),
                      decoration: BoxDecoration(
                        color: MyColor.getSecondaryColor().withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.logout,),
                          const SizedBox(width: 8),
                          Expanded(child: Text('Logout', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeLarge))),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> _screens = [
    const UploadedScreen(),
    const SaveItemScreen(),
    const RecentlyReadScreen(),
    const DownloadBookScreen(),
  ];

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
                                      color: MyColor.getPrimaryColor(),
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
}