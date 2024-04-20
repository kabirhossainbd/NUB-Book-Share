// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:nub_book_sharing/controller/home_controller.dart';
// import 'package:nub_book_sharing/model/response/overview_model.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/audio_to_text/lib/blog_model.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/my_book/book_view.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_images.dart';
//
// class BookScreen extends StatefulWidget {
//   const BookScreen({super.key});
//
//   @override
//   State<BookScreen> createState() => _BookScreenState();
// }
//
// class _BookScreenState extends State<BookScreen> with TickerProviderStateMixin {
//   // late List<BlogPost> blogPosts;
//   late PageController pageController;
//   final Map<int, AnimationController> animationControllers = {};
//   var middleCardIndex = -1;
//
//   ///tabBar
//   int _selectedIndex = 0;
//   late TabController _mainTabController;
//   final List<OverviewModel> _overviewList = [
//     OverviewModel(id: 0, icon: MyImage.book, name: 'Continue Reading',itemCount: 210),
//     OverviewModel(id: 1, icon: MyImage.favorite, name: 'Saved Items',itemCount: 20),
//     OverviewModel(id: 2, icon: MyImage.openBook, name: 'Recently Read',itemCount: 310),
//     OverviewModel(id: 3, icon: MyImage.download, name: 'Download Books',itemCount: 10),
//   ];
//   late ScrollController controller = ScrollController();
//   String tabsModel = '';
//
//   @override
//   void initState() {
//     Get.find<HomeController>().getBookList();
//     Get.find<HomeController>().getAuthorList();
//     _mainTabController = TabController(length: _overviewList.length, vsync: this, initialIndex: _selectedIndex);
//     _mainTabController.addListener(()=> setState(() {
//       _selectedIndex = _mainTabController.index;
//     }));
//     pageController = PageController(viewportFraction: 0.4);
//     pageController.addListener(_calculateMiddleCard);
//
//     // blogPosts = [
//     //   ...BlogPost.blogPosts,
//     //   ...BlogPost.blogPosts,
//     //   ...BlogPost.blogPosts,
//     // ];
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeAnimation();
//     });
//   }
//
//   void _initializeAnimation() {
//     int initialMiddleCard = (pageController.page?.floor() ?? 0) + 2;
//
//     for (int i = 0; i <= initialMiddleCard; i++) {
//       if (i < initialMiddleCard) {
//         animationControllers[i]?.forward();
//       }
//     }
//
//     setState(() {
//       middleCardIndex = initialMiddleCard;
//     });
//   }
//
//   void _calculateMiddleCard() {
//     int newMiddleCard = (pageController.page?.round() ?? 0) + 2;
//
//     if (newMiddleCard > middleCardIndex) {
//       animationControllers[newMiddleCard - 1]?.forward();
//       setState(() {
//         middleCardIndex = newMiddleCard;
//       });
//     }
//
//     if (newMiddleCard < middleCardIndex) {
//       animationControllers[newMiddleCard]?.reverse();
//       setState(() {
//         middleCardIndex = newMiddleCard;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       builder: (home) => Scaffold(
//         backgroundColor: MyColor.getBackgroundColor(),
//         appBar: AppBar(title: const Text('atomsbox')),
//         body: DefaultTabController(
//           length: _overviewList.length,
//           child: Scaffold(
//               backgroundColor: MyColor.getBackgroundColor(),
//               body: NestedScrollView(
//                 headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                   return [
//                     SliverAppBar(
//                       backgroundColor: MyColor.getBackgroundColor(),
//                       toolbarHeight: 16,
//                       leading: const SizedBox(),
//                       leadingWidth: 0,
//                       title: const SizedBox(),
//                       pinned: true,
//                       floating: false,
//                       bottom: TabBar(
//                           dividerColor: Colors.transparent,
//                           controller: _mainTabController,
//                           tabAlignment: TabAlignment.start,
//                           padding: EdgeInsets.zero,
//                           isScrollable: true,
//                           indicatorPadding: EdgeInsets.zero,
//                           indicatorSize: TabBarIndicatorSize.label,
//                           indicator: BoxDecoration(
//                               color: MyColor.getPrimaryColor(),
//                               borderRadius: BorderRadius.circular(8)
//                           ),
//                           labelColor: MyColor.colorWhite,
//                           unselectedLabelColor: MyColor.colorHint,
//                           indicatorColor:  MyColor.getPrimaryColor(),
//                           onTap: (index) => setState(() => _selectedIndex = index),
//                           tabs: _overviewList.map((item){
//                             int index = _overviewList.indexOf(item);
//                             return Tab(child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//                               child: Row(
//                                 children: [
//                                   SvgPicture.asset(item.icon ?? '', color: _selectedIndex == index ? MyColor.colorWhite : MyColor.colorHint,),
//                                   const SizedBox(width: 8),
//                                   Text('${item.name}(${item.itemCount})'),
//                                 ],
//                               ),
//                             ),);
//                           }).toList()
//                       ),
//                     ),
//                   ];
//                 },
//                 body: TabBarView(
//                   controller: _mainTabController,
//                   children: _overviewList.map((item){
//                     return  Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: PageView.builder(
//                         controller: pageController,
//                         scrollDirection: Axis.vertical,
//                         padEnds: false,
//                         itemCount: home.boolList.length,
//                         itemBuilder: (context, index) {
//                           animationControllers.putIfAbsent(index, () => AnimationController(
//                             vsync: this,
//                             duration: const Duration(milliseconds: 800),
//                           ),
//                           );
//
//                           var animation = Tween<double>(begin: 0.0, end: 0.4).animate(
//                             CurvedAnimation(
//                               parent: animationControllers[index]!,
//                               curve: Curves.bounceOut,
//                             ),
//                           );
//
//                           return InkWell(
//                             onTap: () {},
//                             child: BookView(
//                               bookModel: home.boolList[index],
//                               cardIndex: index,
//                               animation: animation,
//                               isReading: true,
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     animationControllers.forEach((key, controller) => controller.dispose());
//     pageController.removeListener(_calculateMiddleCard);
//     pageController.dispose();
//     super.dispose();
//   }
// }
