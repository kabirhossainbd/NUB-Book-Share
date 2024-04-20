import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';

class UploadedScreen extends StatefulWidget {
  const UploadedScreen({super.key});

  @override
  State<UploadedScreen> createState() => _UploadedScreenState();
}

class _UploadedScreenState extends State<UploadedScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: const CustomAppBar(title: 'Upload History',),
        body: SafeArea(
          child: Column(
            children: [

              if(book.isUserBooksEmpty)...[
                const Expanded(child: Center(child: CircularProgressIndicator())),
              ]else if(book.currentUserBooksList.isEmpty)...[
                const Expanded(child: NoDataScreen()),
              ]else...[
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: book.currentUserBooksList.length,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      itemBuilder: (_, index){
                        return BookWidget(bookModel: book.currentUserBooksList[index], isList: true,);
                      }),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
