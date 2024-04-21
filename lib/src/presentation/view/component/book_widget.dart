import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/home/book_details_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_date_converter.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../utils/constants/m_colors.dart';


class BookWidget extends StatelessWidget {
  final BookModel bookModel;
  final bool isReading, isList;
  const BookWidget({super.key, required this.bookModel, this.isReading = true, this.isList = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedController>(
      builder: (saved) => GestureDetector(
        onTap: (){
         Navigator.push(context, PageTransition(child: BookDetailsScreen(bookModel: bookModel), type: PageTransitionType.fade));
        },
        child: Container(
          width: Get.width * 0.5,
          margin: EdgeInsets.symmetric(vertical: isList ? 12 : 0),
          padding:  EdgeInsets.all(isList ? 10 : 0),
          decoration: BoxDecoration(
              color: isList ? MyColor.getCardColor() : null,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// for list view
              if(isList)...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Container(
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient:  LinearGradient(
                                colors: [Colors.transparent, Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.4)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0, 0.2,0.8, 1],
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: '-image${bookModel.hashCode}',
                                  child: CustomImageDemo(
                                    url: bookModel.coverPhoto ?? '',
                                    height: 120,
                                    width: 120,
                                  ),
                                )
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column( crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(alignment: Alignment.topRight,child: InkWell(
                                  onTap: (){
                                    if(saved.savedIdList.contains(bookModel.id ?? '0')){
                                      saved.removeSavedList(bookModel);
                                    }else{
                                      saved.addSavedList(bookModel);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,4,4,0),
                                    child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyColor.getBackgroundColor(),
                                        ),
                                        child:  Icon(saved.savedIdList.contains(bookModel.id ?? '0') ? Icons.favorite : Icons.favorite_border_outlined, size: 20, color: MyColor.colorRed,)),
                                  ),
                                )),
                                Column( crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal:MySizes.paddingSizeExtraSmall, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF2AF287),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Text('New', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 8), textAlign: TextAlign.center,),
                                    ),

                                    const SizedBox(height: 3),
                                    Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(child: Text(bookModel.name ?? '',  style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeSmall), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                      ],
                                    ),
                                    const SizedBox(height: 3,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SvgPicture.asset(MyImage.book, width: 16,height: 16,),
                              Text(bookModel.subjectCode ?? '', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                            ],
                          ),
                          const SizedBox(height: 4),

                          if(bookModel.subName != null)...[
                            Text(bookModel.subName ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                            const SizedBox(height: 4),
                          ],

                          if(bookModel.topicName != null)...[
                            Text(bookModel.topicName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                            const SizedBox(height: 4),
                          ],
                          Row(
                            children: [
                              Text(bookModel.authorName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                height: 10,
                                width: 2,
                                color: MyColor.getTextColor(),
                              ),
                              Text(MyDateConverter.dayMonthYearConvert(bookModel.createAt ?? ''), style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),

                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                if(isReading)...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.4,
                        child: Column(
                          children: [
                            Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Progress', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall)),
                                Text('50%', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              width: Get.width * 0.4,
                              lineHeight: 5.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(50),
                              backgroundColor: MyColor.getGreyColor(),
                              progressColor: MyColor.getPrimaryColor(),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          SvgPicture.asset(MyImage.book, width: 14,height: 14,),
                          const SizedBox(width: 8),
                          Text('Continue Reading', style: robotoRegular.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeDefault),)
                        ],
                      )
                    ],
                  )
                ],
              ]else...[

                /// for gridview
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Hero(
                      tag: '-image${bookModel.hashCode}',
                      child: Center(
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient:  LinearGradient(
                              colors: [Colors.transparent, Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.4)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 0.2,0.8, 1],
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomImageDemo(
                                url: bookModel.coverPhoto ?? '',
                                height: 160,
                              )
                          ),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(alignment: Alignment.topRight,child: InkWell(
                              onTap: (){
                                if(saved.savedIdList.contains(bookModel.id ?? '0')){
                                  saved.removeSavedList(bookModel);
                                }else{
                                  saved.addSavedList(bookModel);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0,4,4,0),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyColor.getBackgroundColor(),
                                    ),
                                    child:  Icon(saved.savedIdList.contains(bookModel.id ?? '0') ? Icons.favorite : Icons.favorite_border_outlined, size: 20, color: MyColor.colorRed,)),
                              ),
                            )),
                            Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal:MySizes.paddingSizeExtraSmall, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2AF287),
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Text('New', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 8), textAlign: TextAlign.center,),
                                ),

                                const SizedBox(height: 3),
                                Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(child: Text(bookModel.name ?? '',  style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeSmall), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                  ],
                                ),
                                const SizedBox(height: 3,),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                if(isReading && bookModel.progress != null)...[
                  SizedBox(
                    width: Get.width * 0.49,
                    child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Progress', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall)),
                        Text('${bookModel.progress}%', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall)),

                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    width: Get.width * 0.49,
                    lineHeight: 5.0,
                    percent: bookModel.progress!.toDouble()/100,
                    barRadius: const Radius.circular(50),
                    backgroundColor: MyColor.getGreyColor(),
                    progressColor: MyColor.getPrimaryColor(),
                  ),
                  const SizedBox(height: 4),
                ],

                if(bookModel.subjectCode != null)...[
                  Row(
                    children: [
                      SvgPicture.asset(MyImage.book, width: 16,height: 16,),
                      const SizedBox(width: 4),
                      Text(bookModel.subjectCode ?? '', style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeSmall),),
                    ],
                  ),
                ],

                const SizedBox(height: 4),
                Text(bookModel.topicName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),maxLines: 1, overflow: TextOverflow.ellipsis,),

                const SizedBox(height: 4),
                Text(bookModel.description ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis,),

                const SizedBox(height: 4),
                Row(
                  children: [
                    if(bookModel.authorName != null)...[
                      Flexible(child: Text(bookModel.authorName ?? '', style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 10,
                        width: 2,
                        color: MyColor.getTextColor(),
                      ),
                    ],
                    Text(MyDateConverter.dayMonthYearConvert(bookModel.createAt ?? ''), style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),

                  ],
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }
}
