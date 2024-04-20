import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/services/firebase_auth_service.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';
import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/message/message_box_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class BookDetailsScreen extends StatefulWidget {
  final BookModel bookModel;
  const BookDetailsScreen({super.key, required this.bookModel});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: AppBar(
        leading: IconButton(onPressed: Get.back, icon: const Icon(Icons.arrow_back, size: 28,)),
        title: Text('Book Details', style: robotoBold.copyWith(fontSize: MySizes.fontSizeExtraLarge),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.vertical_align_bottom, size: 28,)),
          const SizedBox(width: 8)
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 280, width: 120,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(15,120,15,15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColor.colorWhite
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(color: MyColor.colorWhite,height: 280, width: double.infinity,),
                  Column(
                    children: [
                      const SizedBox(height: 120),
                      Text(widget.bookModel.title ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                      const SizedBox(height: 5),
                      Text(widget.bookModel.topicName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                      const SizedBox(height: 5),
                      Row( mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(MyImage.book),
                          Text(widget.bookModel.subjectCode ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: -110,
                    child: Hero(
                      tag: '-image${widget.bookModel.hashCode}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CustomImageDemo(
                          url: widget.bookModel.coverPhoto ?? '',
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                      bottom: 0,
                      left: 0, right: 0,
                      child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.person, color: MyColor.getTextColor(),),
                                const SizedBox(width: 6),
                                Expanded(child: Text(widget.bookModel.authorName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Row(
                              children: [
                                SvgPicture.asset(MyImage.book),
                                const SizedBox(width: 6),
                                Expanded(child: Text(widget.bookModel.topicName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Row(
                              children: [
                                SvgPicture.asset(MyImage.openBook),
                                const SizedBox(width: 6),
                                Expanded(child: Text(widget.bookModel.subjectCode ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),

                        ],
                      ),
                  )
                ],
              ),
            ),

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
                  GestureDetector(
                    onTap: (){
                      // ChatUser chatUser  = ChatUser(id: widget.bookModel.publisherId, name: widget.bookModel.name, email: widget.bookModel.email, pushToken: widget.bookModel.pushToken);
                      // Get.to(AuthorProfileScreen(authorModel: chatUser));
                    },
                      child: ProfileAvatar(url: widget.bookModel.photo ?? '',)),
                  const SizedBox(width: 8),
                  Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.bookModel.name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                      const SizedBox(height: 4),
                      Text(widget.bookModel.about ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                    ],
                  )),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      if(SessionService().userId != widget.bookModel.publisherId)...[
                        IconButton(onPressed: (){
                          ChatUser chatUser  = ChatUser(id: widget.bookModel.publisherId, name: widget.bookModel.name, email: widget.bookModel.email, pushToken: widget.bookModel.pushToken);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: chatUser)));
                        }, icon: const Icon(CupertinoIcons.chat_bubble_2)),
                      ],

                      IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Details', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.bookModel.description ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
            ),
          ],
        ),
    ),
    );
  }
}
