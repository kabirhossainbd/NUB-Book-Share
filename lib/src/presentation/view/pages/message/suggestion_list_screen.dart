// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nub_book_sharing/controller/chat_controller.dart';
// import 'package:nub_book_sharing/services/apis.dart';
// import 'package:nub_book_sharing/services/firebase_auth_service.dart';
// import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
// import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
//
// class SuggestionListScreen extends StatefulWidget {
//   const SuggestionListScreen({super.key});
//
//   @override
//   State<SuggestionListScreen> createState() => _SuggestionListScreenState();
// }
//
// class _SuggestionListScreenState extends State<SuggestionListScreen> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ChatController>(
//       builder: (chat) => Scaffold(
//         backgroundColor: MyColor.getBackgroundColor(),
//         body: SafeArea(
//           child: ListView(
//             padding: const EdgeInsets.all(16),
//             children: [
//
//               /// for search
//               InkWell(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 hoverColor: Colors.transparent,
//                 focusColor: Colors.transparent,
//                 // onTap: () => Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const SearchScreen(isActiveSearch: true))),
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                   decoration: BoxDecoration(
//                       color: MyColor.colorSecondary,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: const [BoxShadow(
//                           color: Color(0x1018280D),
//                           spreadRadius: 0.1,
//                           blurRadius: 0.1,
//                           offset: Offset(0.5, 0.5)
//                       )
//                       ]
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, right: 8),
//                         child: Icon(CupertinoIcons.search,size: 20, color: MyColor.getGreyColor(),),
//                       ),
//                       Text('search'.tr,style: robotoLight.copyWith(color: MyColor.getGreyColor()),)
//                     ],
//                   ),
//                 ),
//               ),
//
//
//               const SizedBox(height: MySizes.marginSizeMiniSmall,),
//
//               FirebaseAnimatedList(
//                   shrinkWrap: true,
//                   query: chat.chatUsersList,
//                   itemBuilder: (_,snapshot, animation, index){
//                     if(SessionService().userId != snapshot.child('uid').value.toString()){
//                       return GestureDetector(
//                         onTap:() async{
//                           Navigator.pop(context);
//                           if (snapshot.child('email').value != null) {
//                             await APIs.addChatUser(snapshot.child('email').value.toString()).then((value) {
//                               if (!value) {
//                                 myToast('User does not Exists!');
//                               }else{
//                                // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
//                               }
//                             });
//                           }
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               color: MyColor.getBackgroundColor(),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: MyColor.getGreyColor().withOpacity(0.8),
//                                     spreadRadius: 1,
//                                     blurRadius: 2,
//                                     offset: const Offset(2,2)
//                                 )
//                               ]
//                           ),
//                           child: Row(
//                             children: [
//                              ProfileAvatar(url: ''),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                   child: Column( crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(snapshot.child('phone').value.toString(), style: robotoBold.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault)),
//                                       const SizedBox(height: 4),
//                                       Text(snapshot.child('email').value.toString(), style: robotoRegular.copyWith(color: MyColor.getTextColor().withOpacity(0.6), fontSize: MySizes.fontSizeSmall)),
//                                     ],
//                                   )),
//
//                               const Text('Today')
//                             ],
//                           ),
//                         ),
//                       );
//                     }else{
//                       return const SizedBox();
//                     }
//                   })
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
