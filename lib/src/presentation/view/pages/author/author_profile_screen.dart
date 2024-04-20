import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/services/firebase_auth_service.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/message/message_box_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class AuthorProfileScreen extends StatefulWidget {
  final ChatUser authorModel;
  const AuthorProfileScreen({super.key, required this.authorModel});

  @override
  State<AuthorProfileScreen> createState() => _AuthorProfileScreenState();
}

class _AuthorProfileScreenState extends State<AuthorProfileScreen> {

  @override
  void initState() {
   Get.find<BookController>().getAuthorBooks(widget.authorModel.id ?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => GetBuilder<HomeController>(
        builder: (home) => Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          appBar: const CustomAppBar(title: 'Publisher Profile', isShowIcon: true,),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [

                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.fromLTRB(16,16,16,0),
                  decoration: BoxDecoration(
                    color: MyColor.getCardColor(),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: MyColor.getGreyColor().withOpacity(0.1),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        offset: const Offset(2,2),
                      ), BoxShadow(
                        color: MyColor.getGreyColor().withOpacity(0.1),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        offset: const Offset(-1,-1),
                      )
                    ]
                  ),
                  child: Row(
                    children: [
                      ProfileAvatar(url: widget.authorModel.profile ?? '',),
                      const SizedBox(width: 8),
                      Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.authorModel.name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                          const SizedBox(height: 4),
                          Text(widget.authorModel.occupation ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                        ],
                      )),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          if(SessionService().userId != widget.authorModel.id)...[
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.authorModel)));
                            }, icon: const Icon(CupertinoIcons.chat_bubble_2)),

                          ],IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 31),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Details', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: MyColor.getCardColor(),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.1),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: const Offset(2,2),
                        ), BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.1),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: const Offset(-1,-1),
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customRow(MyImage.email,widget.authorModel.email ?? ''),
                      _customRow(MyImage.call,widget.authorModel.phone ?? ''),
                      _customRow(MyImage.address,widget.authorModel.address ?? ''),
                      _customRow(MyImage.start,widget.authorModel.varsityId ?? ''),
                      _customRow(MyImage.about,widget.authorModel.about ?? ''),
                    ],
                  ),
                ),


                const SizedBox(height: 16),
                _customTitleRow("Recent publish", onTap: (){}),
                if(book.isAuthorBooksEmpty)...[
                 const Center(child: CircularProgressIndicator()),
                ]else...[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          children: List.generate(book.authorBooksList.length > 5 ? 5 : book.authorBooksList.length,(index){
                            return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BookWidget(bookModel: book.authorBooksList[index], isReading: false,),
                            );
                          }),
                        )
                    ),
                  ),
                ],

               /* _customTitleRow("Continue reading", onTap: (){}),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: List.generate(home.boolList.length > 5 ? 5 : home.boolList.length,(index){
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookWidget(bookModel: home.boolList[index]),
                          );
                        }),
                      )
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  _customRow(String icon,String title){
    return title.isNotEmpty ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
         SvgPicture.asset(icon, height: 16, width: 16),
          const SizedBox(width: 4),
          Text(title, style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
        ],
      ),
    ) : const SizedBox();
  }


  _customTitleRow(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,16,16,8),
      child: Row( crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title, style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeExtraLarge ),)),
          GestureDetector(
            onTap: onTap,
            child: Text("See more", style: robotoBold.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeDefault ),),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: MyColor.colorPrimary,size: 14,)
        ],
      ),
    );
  }
}
