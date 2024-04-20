import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';

class SaveItemScreen extends StatefulWidget {
  const SaveItemScreen({super.key});

  @override
  State<SaveItemScreen> createState() => _SaveItemScreenState();
}

class _SaveItemScreenState extends State<SaveItemScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedController>(
      builder: (saved) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: const CustomAppBar(title: 'Saved Item',),
        body:  SafeArea(
          child: Column(
            children: [
              if(saved.savedList.isEmpty)...[
                const Expanded(child: NoDataScreen()),
              ]else...[
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: saved.savedList.length,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      itemBuilder: (_, index){
                        return BookWidget(bookModel: saved.savedList[index], isList: true,);
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
