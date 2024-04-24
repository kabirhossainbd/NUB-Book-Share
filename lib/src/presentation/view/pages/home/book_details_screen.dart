import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/services/firebase_auth_service.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';
import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/audio_to_text/pdf_viewer_details_screen.dart';
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

class _BookDetailsScreenState extends State<BookDetailsScreen>  with SingleTickerProviderStateMixin{

  late TabController _mainTabController;

  @override
  void initState() {
    Get.find<BookController>().getAuthorDetails(widget.bookModel.publisherId ?? '0');
    _mainTabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _mainTabController.addListener(()=> setState(() {}));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => Scaffold(
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
                height: 240, width: double.infinity,
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
                        const SizedBox(height: 100),
                        Text(widget.bookModel.title ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                        const SizedBox(height: 5),
                        Text(widget.bookModel.topicName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
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
                                  SvgPicture.asset(MyImage.language),
                                  const SizedBox(width: 6),
                                  Expanded(child: Text('English', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Row(
                                children: [
                                  SvgPicture.asset(MyImage.book),
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

              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.grey[200],
                    controller: _mainTabController,
                    isScrollable: true,
                    tabs: const [
                      Tab(child: Row(
                        children: [
                          Text('Details')
                        ],
                      ),),
                      Tab(child: Row(
                        children: [
                          Text('Publisher Profile')
                        ],
                      ),),
                    ]),
              ),

              ///for tabview
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text('Details', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),textAlign: TextAlign.start,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(widget.bookModel.description ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                    ),
                  ],
                ),

                Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(book.authorDetails != null)...[
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
                            ProfileAvatar(url: book.authorDetails!.profile ?? '',),
                            const SizedBox(width: 8),
                            Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(book.authorDetails!.name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                                const SizedBox(height: 4),
                                Text(book.authorDetails!.occupation ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                              ],
                            )),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                if(SessionService().userId != book.authorDetails!.id)...[
                                  IconButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: book.authorDetails!)));
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
                        child: Text('Overview', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
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
                            _customRow(MyImage.email,book.authorDetails!.email ?? ''),
                            _customRow(MyImage.call,book.authorDetails!.phone ?? ''),
                            _customRow(MyImage.address,book.authorDetails!.address ?? ''),
                            _customRow(MyImage.start,book.authorDetails!.varsityId ?? ''),
                            _customRow(MyImage.about,book.authorDetails!.about ?? ''),
                          ],
                        ),
                      ),
                    ]else...[
                      const Center(child: CircularProgressIndicator())
                    ],

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
                  ],
                ),

              ][_mainTabController.index],

              const SizedBox(height: 12),
            ],
          ),
      ),

        bottomNavigationBar: Container(
          color: MyColor.colorWhite,
          height: 60,
          width: double.infinity,
          child: GestureDetector(
            onTap: (){
               Get.to(PdfViewerDetails(link: widget.bookModel.pdfUrl ?? '',));
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(12,4,12,8),
              decoration: BoxDecoration(
                color: MyColor.getPrimaryColor(),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Text('Start Reading', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeLarge),),
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
