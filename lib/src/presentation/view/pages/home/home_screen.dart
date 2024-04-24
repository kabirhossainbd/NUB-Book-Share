import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/author/author_profile_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/author/author_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/home/ggg.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  final TextEditingController _searchCon  = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  late TabController _mainTabController;
  final mainList = ["For you", "Home","Downloads", "Earnings"];
  final secondaryList = ["CSE", "EEE","TextTile", "LLB"];
  late ScrollController controller = ScrollController();
  String tabsModel = '';
  @override
  void initState() {
    Get.find<BookController>().getAllSlider();
    Get.find<BookController>().getAllBooks(false);
    _mainTabController = TabController(length: mainList.length, vsync: this);
    _mainTabController.addListener(()=> setState(() {}));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (book) => GetBuilder<HomeController>(
        builder: (home) => Scaffold(
          backgroundColor: MyColor.getBackgroundColor(),
          body: DefaultTabController(
            length: mainList.length,
            child: Scaffold(
                backgroundColor: MyColor.getBackgroundColor(),
                body: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: MyColor.getBackgroundColor(),
                        toolbarHeight: 80,
                        leading: const SizedBox(),
                        leadingWidth: 0,
                        title:  Container(
                          height: 48,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0,16,0,10),
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
                                hintText: 'Search by subject name or code',
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
                        pinned: true,
                        floating: true,
                      ),
                    ];
                  },
                  body: RefreshIndicator(
                    onRefresh: () async{
                      await Get.find<BookController>().getAllBooks(true);
                    },
                    child: ListView(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: false,
                              viewportFraction: 0.8,
                              aspectRatio: 2.5,
                              enlargeCenterPage: false,
                              onPageChanged: (index, page){
                                home.changeSelectBannerIndex(index);
                              }),
                          items: book.sliderList.map((item){
                            return Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                  child: CustomImageDemo(
                                    url: item.photo ?? '',
                                    shimmerEnable: true,
                                    width: 1000.0,
                                  )),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _pageIndicators(book.sliderList.length, home),
                        ),

                        Column(
                          children: [
                            _customTitleRow("Publisher", onTap: ()=> Navigator.push(context, PageTransition(child: const AuthorScreen(), type: PageTransitionType.rightToLeft))),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: book.authorList.length >= 4 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                                children: List.generate(book.authorList.length > 4 ? 4 : book.authorList.length,(index){
                                  /*String name = '';
                                  if(book.authorList[index].name != null){
                                    name = book.authorList[index].name!.length > 6
                                        ? '${book.authorList[index].name!.substring(0, 10)}...'
                                        : book.authorList[index].name ?? '';
                                  }*/
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    onTap: (){
                                      Navigator.push(context, PageTransition(child:  AuthorProfileScreen(authorModel: book.authorList[index],), type: PageTransitionType.rightToLeft));
                                    } ,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: book.authorList.length >= 4 ? 80 : 100,
                                      padding: book.authorList.length >= 4 ? EdgeInsets.zero : const EdgeInsets.only(left: 8,right: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: CustomImageDemo(
                                              url: book.authorList[index].profile ?? '',
                                              height: 80,
                                              width: 80,
                                              shimmerEnable: false,
                                            ),
                                          ),
                                          const SizedBox(height: 8,),
                                          Text(book.authorList[index].name ?? "", style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeDefault), maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            _customTitleRow("Continue reading", onTap: (){
                             home.setPage(1);
                             home.setSelectedIndex(0, true);
                            }),
                            const SizedBox(height: 8),
                          ],
                        ),


                        if(book.isBookEmpty)...[
                          const Center(child: CircularProgressIndicator()),
                        ]else if(book.bookDataList.isEmpty)...[
                          const NoDataScreen()
                        ]else...[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Row(
                                  children: List.generate(book.bookDataList.length > 5 ? 5 : book.bookDataList.length,(index){
                                    return  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: BookWidget(bookModel: book.bookDataList[index]),
                                    );
                                  }),
                                )
                            ),
                          ),
                        ],

                        _customTitleRow("Trending books", onTap: (){
                          home.setSelectedIndex(1, true).then((value) =>  home.setPage(1));
                        }),
                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: secondaryList.map((item){
                              int index = secondaryList.indexOf(item);
                              return GestureDetector(
                                onTap: ()=> home.setTrendingIndex(index, true),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: home.selectTrendingIndex == index ? MyColor.getPrimaryColor() : Colors.transparent,
                                    border: Border.all(color: MyColor.colorPrimary, width: 1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(item, style: robotoRegular.copyWith(color: home.selectTrendingIndex == index ? MyColor.colorWhite : MyColor.colorPrimary, fontSize: MySizes.fontSizeDefault),),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),


                        if(book.isBookEmpty)...[
                          const Center(child: CircularProgressIndicator()),
                        ]else if(book.bookDataList.isEmpty)...[
                          const NoDataScreen()
                        ]else...[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Row(
                                  children: List.generate(book.bookDataList.length > 5 ? 5 : book.bookDataList.length,(index){
                                    return  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: BookWidget(bookModel: book.bookDataList[index], isReading: false,),
                                    );
                                  }),
                                )
                            ),
                          ),
                        ],

                      ],
                    ),
                  )
                )),
          )
        ),
      ),
    );
  }



  List<Widget> _pageIndicators(int index, HomeController home) {
    List<Widget> indicators = [];
    for (int i = 0; i < index; i++) {
      indicators.add(
        Container(
          width:  10,
          height: 10,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == home.selectBannerIndex
                ? MyColor.getPrimaryColor()
                : Colors.grey[400],
            borderRadius: i == home.selectBannerIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }

  _customTitleRow(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,16,16,0),
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

