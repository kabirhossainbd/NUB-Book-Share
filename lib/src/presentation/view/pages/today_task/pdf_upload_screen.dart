import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/drawer_dashboard.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:nub_book_sharing/src/utils/constants/my_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PDFUploadScreen extends StatefulWidget {
  final BookModel bookModel;
  const PDFUploadScreen({super.key, required this.bookModel});

  @override
  State<PDFUploadScreen> createState() => _PDFUploadScreenState();
}

class _PDFUploadScreenState extends State<PDFUploadScreen> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: const CustomAppBar(title: 'Upload book', isBackButtonExist: false,),
        body: SafeArea(
          child: GestureDetector(
            onTap: ()=> FocusScope.of(context).unfocus(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Text('Step 2: ', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                    Text('PDF Upload', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  ],
                ),
                const SizedBox(height: MySizes.paddingSizeLarge,),
                DottedBorder(
                    dashPattern: const [8, 4],
                    strokeWidth: 1.5,
                    color: MyColor.getSecondaryColor(),
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(16),
                    child: Center(
                      child: InkWell(
                          onTap: () async {
                            if(Platform.isIOS){
                              book.pickImage().then((value) {
                                setState(() {
                                  //isPhotoEmpty = true;
                                });
                              });
                            }else{
                              customImagePickFile().then((value) async{
                                if(value){
                                  book.pickImage().then((value) {
                                    setState(() {
                                      // isPhotoEmpty = true;
                                    });
                                  });
                                }
                              });
                            }
                          },
                          child: book.file != null ? Stack(
                              alignment: Alignment.center,
                              children:[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(File(book.file!.path),
                                    height: 120, width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: MyColor.getCardColor(),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row( mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(MyImage.upload, width: 16, height: 16,),
                                        const SizedBox(width: 8),
                                        Text('Upload photo', style: robotoLight.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor()),)
                                      ],
                                    )
                                ),
                              ]
                          ) : Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: MyColor.getBackgroundColor(),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: MyColor.getCardColor(),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row( mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(MyImage.upload, width: 16, height: 16,),
                                        const SizedBox(width: 8),
                                        Text('Upload photo', style: robotoLight.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor()),)
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                    )
                ),


                if(book.isPdfUploading)...[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MyColor.getGreyColor().withOpacity(0.4))
                    ),
                    child: Row( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack( alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(MyImage.fileIcon),
                            if(book.uploading)...[
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                ),
                              )
                            ]

                          ],
                        ),
                        const SizedBox(height: 12),
                        const SizedBox(width: 8),
                        Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(book.pdfFileName, style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                const SizedBox(width: 5),
                                if((book.progress * 100).round() != 100)...[
                                  InkWell(
                                    onTap: (){
                                      book.deletePDFFile();
                                    },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(CupertinoIcons.delete, color: MyColor.getTextColor(), size: 16,),
                                      ))
                                ]else...[
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: MyColor.getPrimaryColor(),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: const Icon(CupertinoIcons.check_mark, color: MyColor.colorWhite, size: 12,),
                                  )
                                ]
                              ],
                            ),
                            Text('${book.fileSize.round()} ${convertKBToMB(book.fileSize)}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearPercentIndicator(
                                    padding: EdgeInsets.zero,
                                    lineHeight: 8.0,
                                    percent: book.progress,
                                    barRadius: const Radius.circular(50),
                                    backgroundColor: MyColor.getGreyColor(),
                                    progressColor: MyColor.getPrimaryColor(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('${(book.progress * 100).round()}%', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge)),
                              ],
                            ),

                          ],
                        ))
                      ],
                    ),
                  ),
                ]else...[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MyColor.getGreyColor().withOpacity(0.4))
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: MyColor.getGreyColor().withOpacity(0.4))
                          ),
                          child: SvgPicture.asset(MyImage.uploadCloud),
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()..onTap =()=> book.pickPDF(),
                              text: 'Click to upload ',
                              style: robotoBold.copyWith(color: MyColor.getPrimaryColor(), fontSize: MySizes.fontSizeLarge),
                              children: [
                                TextSpan(
                                  text: 'or drag and drop PDF',
                                  style: robotoLight.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),
                                )
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                ],

              /*  Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: book.pdfUrl == ""
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: book.isPdfUploading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: MyColor.getBackgroundColor(),
                            ),
                          )
                              : book.pdfUrl == ""
                              ? InkWell(
                            onTap: () {
                              book.pickPDF();
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(MyImage.upload),
                                const SizedBox(width: 8),
                                Text(
                                  "Book PDF",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : InkWell(
                            onTap: () {
                              book.pdfUrl = "";
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  MyImage.download,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Delete Pdf",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),*/


                /// for button
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CustomButton(
                      isColor: (!book.uploading && book.isPdfUploading),
                      isLoader: book.isPostUploading,text: 'Upload', onTap: (){
                        if(!book.uploading && book.isPdfUploading){
                          book.createBook(widget.bookModel).then((value){
                            Navigator.pushAndRemoveUntil(Get.context!, PageTransition(child: const DashboardScreen(), type: PageTransitionType.bottomToTop), (route) => false);
                          });
                        }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertKBToMB(double value){
    return (value/1024) > 1 ? 'MB' : 'KB';
  }
}

