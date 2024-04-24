import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/author/widget/author_view.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {

  final TextEditingController _searchCon  = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => GetBuilder<HomeController>(
        builder: (home) => Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          appBar: const CustomAppBar(title: "Author | Publisher", isShowIcon: true,),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  height: 48,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: MyColor.getBorderColor()),
                  ),
                  child: TextField(
                    controller: _searchCon,
                    focusNode: _searchFocus,
                    style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault, color: MyColor.getTextColor()),
                    cursorColor: Theme.of(context).primaryColor,
                    autofocus: false,
                    decoration: InputDecoration(
                        fillColor: MyColor.getBackgroundColor(),
                        hintText: 'Search by name',
                        contentPadding: const EdgeInsets.only(left: 12,right: 12,top: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(8),left: Radius.circular(8)),
                          borderSide: BorderSide(style: BorderStyle.none, width: 0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(8),left: Radius.circular(8)),
                          borderSide: BorderSide(style: BorderStyle.none, width: 0),
                        ),
                        isDense: true,
                        hintStyle: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getGreyColor()),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.search, size: 24, color: MyColor.colorPrimary,),
                        ),
                        suffixIcon: _searchCon.text.isNotEmpty ? GestureDetector(
                          onTap: (){
                            setState(() {
                              _searchCon.clear();
                            });
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(Icons.cancel)
                          ),
                        ) : const SizedBox()
                    ),
                    // TODO need to write it down in own controller just like that
                    //onChanged: chat.searchChat,
                  ),
                ),

                const SizedBox(height: 16),
                _customTitleRow("Publisher", onTap: (){}),
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 140
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    itemCount: book.authorList.length,
                    itemBuilder: (context, idx) =>  AuthorView(authorModel: book.authorList[idx])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _customTitleRow(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row( crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(title, style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeExtraLarge ),)),
          GestureDetector(
            onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,8,0),
                child: SvgPicture.asset(MyImage.filter),
              ))
        ],
      ),
    );
  }
}
