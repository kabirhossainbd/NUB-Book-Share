import 'package:flutter/material.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/author/author_profile_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';

class AuthorView extends StatefulWidget {
  final ChatUser authorModel;
  const AuthorView({super.key, required this.authorModel});

  @override
  State<AuthorView> createState() => _AuthorViewState();
}

class _AuthorViewState extends State<AuthorView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      //TODO need to check if i messaged before or not
      onTap: (){
       Navigator.push(context, PageTransition(child:  AuthorProfileScreen(authorModel: widget.authorModel,), type: PageTransitionType.rightToLeft));
      } ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CustomImageDemo(
              url: widget.authorModel.profile ?? '',
              height: 80,
              width: 80,
              shimmerEnable: false,
            ),
          ),
          const SizedBox(height: 8,),
          Text(widget.authorModel.name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault), overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
