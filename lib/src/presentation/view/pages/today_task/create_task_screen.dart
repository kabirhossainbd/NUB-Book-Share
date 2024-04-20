import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_text_field.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_button.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/today_task/pdf_upload_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_date_converter.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:nub_book_sharing/src/utils/constants/my_helper.dart';
import 'package:page_transition/page_transition.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {

  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();

  final TextEditingController _topicController = TextEditingController();
  final FocusNode _topicFocus = FocusNode();

  final TextEditingController _subController = TextEditingController();
  final FocusNode _subFocus = FocusNode();

  final TextEditingController _authorController = TextEditingController();
  final FocusNode _authorFocus = FocusNode();

  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();

  DateTime dateTime = DateTime.now();
  DateTime setTime = DateTime.now();

  bool _isBtnActive = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book){
        if(book.file != null && _titleController.text.isNotEmpty && _topicController.text.isNotEmpty && book.selectDate != null && _descriptionController.text.isNotEmpty ){
          _isBtnActive = true;
        }else{
          _isBtnActive = false;
        }
        return Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          body: SafeArea(
            child: GestureDetector(
              onTap: ()=> FocusScope.of(context).unfocus(),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Row(
                    children: [
                      Text('Step 1: ', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeLarge),),
                      Text('Listing Summary', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
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


                  /// for title
                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Book Title/ Subject Name *', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  CustomTextField(
                    controller: _titleController,
                    focusNode: _titleFocus,
                    nextFocus: _topicFocus,
                    hintText: 'Type product title',
                    fillColor: MyColor.colorWhite,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                    backgroundColor: MyColor.colorWhite,
                    isbBorderColor: true,
                    isShowSuffixIcon: true,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (text)=>setState(() {}),
                  ),

                  /// for Category
                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Book Category/ Topic Name *', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  CustomTextField(
                    controller: _topicController,
                    focusNode: _topicFocus,
                    nextFocus: _subFocus,
                    hintText: 'Type product title',
                    fillColor: MyColor.colorWhite,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                    backgroundColor: MyColor.colorWhite,
                    isbBorderColor: true,
                    isShowSuffixIcon: true,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (text)=>setState(() {}),
                  ),

                  /// for Subject Code
                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Subject Code', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  CustomTextField(
                    controller: _subController,
                    focusNode: _subFocus,
                    nextFocus: _authorFocus,
                    hintText: 'Type product title',
                    fillColor: MyColor.colorWhite,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                    backgroundColor: MyColor.colorWhite,
                    isbBorderColor: true,
                    isShowSuffixIcon: true,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (text)=>setState(() {}),
                  ),


                  /// for Author Name
                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Author Name', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  CustomTextField(
                    controller: _authorController,
                    focusNode: _authorFocus,
                    nextFocus: _descriptionFocus,
                    hintText: 'Type product title',
                    fillColor: MyColor.colorWhite,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    capitalization: TextCapitalization.words,
                    backgroundColor: MyColor.colorWhite,
                    isbBorderColor: true,
                    isShowSuffixIcon: true,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (text)=>setState(() {}),
                  ),


                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Location *', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  GestureDetector(
                    onTap: () async{
                      DateTime? dateTime = await getDate(context);
                      if(dateTime != null) {
                        book.updateDate(dateTime, true);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        children: [
                          Expanded(child:  Text(book.selectDate != null ? MyDateConverter.convertTaskTime(book.selectDate!) : 'Select date', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault),)),
                          Icon(CupertinoIcons.calendar_today, color: MyColor.getSecondaryColor(),)
                        ],
                      ),
                    ),
                  ),


                  /// for description Name
                  const SizedBox(height: MySizes.paddingSizeLarge,),
                  Text('Book Description *', style: robotoLight.copyWith(color: MyColor.getTitleColor(), fontSize: MySizes.fontSizeLarge),),
                  const SizedBox(height: 6,),
                  CustomTextField(
                    maxLines: 4,
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    hintText: 'Write There...',
                    fillColor: MyColor.colorWhite,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    capitalization: TextCapitalization.sentences,
                    backgroundColor: MyColor.colorWhite,
                    isbBorderColor: true,
                    isShowSuffixIcon: true,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (text)=>setState(() {}),
                  ),

                  /// for button
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomButton(isColor: _isBtnActive,isLoader: book.isPostUploading,text: 'Next', onTap: (){
                      BookModel bookModel = BookModel(
                          name: _titleController.text,
                          topicName: _topicController.text,
                          authorName: _authorController.text,
                          subjectCode: _subController.text,
                          description: _descriptionController.text,
                          createAt: MyDateConverter.convertTaskTime(book.selectDate!),
                          progress: 100
                      );
                      Navigator.push(context, PageTransition(child:  PDFUploadScreen(bookModel: bookModel), type: PageTransitionType.rightToLeft));
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// for date
  Future<DateTime?> getDate(BuildContext context) {
    return showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      selectableDayPredicate: (DateTime val) => true,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
              datePickerTheme: DatePickerThemeData(
                backgroundColor: Colors.white,
                headerBackgroundColor: MyColor.getPrimaryColor(),
                headerForegroundColor: MyColor.colorWhite,

              ),
              colorScheme: ColorScheme(
                  background: Colors.cyanAccent,
                  onBackground: Colors.cyanAccent,
                  brightness: Brightness.light,
                  primary: MyColor.getPrimaryColor(),
                  onPrimary: MyColor.colorWhite,
                  onPrimaryContainer: Colors.white,
                  secondary: Colors.pink,
                  onSecondary: Colors.pink,
                  error: Colors.red,
                  onError: Colors.red,
                  surface: MyColor.getTextColor(),
                  onSurface: MyColor.getTextColor())
          ),
          child: child!,
        );
      },
    );
  }
}
