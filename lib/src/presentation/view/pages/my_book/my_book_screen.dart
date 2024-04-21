import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/model/response/overview_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';

class MyBookScreen extends StatefulWidget {
  final int selectedIndex;
  const MyBookScreen({super.key, this.selectedIndex = 0});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> with SingleTickerProviderStateMixin{



  late TabController _mainTabController;
  final List<OverviewModel> _overviewList = [
    OverviewModel(id: 0, icon: MyImage.book, name: 'Continue Reading',itemCount: 210),
    OverviewModel(id: 1, icon: MyImage.favorite, name: 'Saved Items',itemCount: 20, ),
    OverviewModel(id: 2, icon: MyImage.openBook, name: 'Recently Upload',itemCount: 310),
    OverviewModel(id: 3, icon: MyImage.download, name: 'Download Books',itemCount: 10),
  ];
  late ScrollController controller = ScrollController();
  String tabsModel = '';
  @override
  void initState() {
    _mainTabController = TabController(length: _overviewList.length, vsync: this, initialIndex: Get.find<HomeController>().selectedIndex);
    _mainTabController.addListener(()=> setState(() {
     Get.find<HomeController>().setSelectedIndex(_mainTabController.index, true);
    }));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedController>(
      builder: (saved) => GetBuilder<BookController>(
        builder: (book) => GetBuilder<HomeController>(
          builder: (home) => Scaffold(
              backgroundColor: MyColor.getBackgroundColor(),
              body: DefaultTabController(
                length: _overviewList.length,
                child: Scaffold(
                    backgroundColor: MyColor.getBackgroundColor(),
                    body: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            backgroundColor: MyColor.getBackgroundColor(),
                            toolbarHeight: 16,
                            leading: const SizedBox(),
                            leadingWidth: 0,
                            title: const SizedBox(),
                            pinned: true,
                            floating: false,
                            bottom: TabBar(
                                dividerColor: Colors.transparent,
                                controller: _mainTabController,
                                tabAlignment: TabAlignment.start,
                                padding: EdgeInsets.zero,
                                isScrollable: true,
                                indicatorPadding: EdgeInsets.zero,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                  color: MyColor.getPrimaryColor(),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                labelColor: MyColor.colorWhite,
                                unselectedLabelColor: MyColor.colorHint,
                                indicatorColor:  MyColor.getPrimaryColor(),
                                onTap: (index) => home.setSelectedIndex(index, true),
                                tabs: _overviewList.map((item){
                                  int index = _overviewList.indexOf(item);
                                  return Tab(child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(item.icon ?? '', color: home.selectedIndex == index ? MyColor.colorWhite : MyColor.colorHint,),
                                        const SizedBox(width: 8),
                                        Text('${item.name}(${item.itemCount})'),
                                      ],
                                    ),
                                  ),);
                                }).toList()
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        controller: _mainTabController,
                        children: _overviewList.map((item){
                          return  RefreshIndicator(
                            onRefresh: ()async{
                             await Get.find<BookController>().getAllBooks(true);
                            },
                            child: Column(
                              children: [
                                if(item.id == 0)...[
                                  if(book.isBookEmpty)...[
                                    const Expanded(child: Center(child: CircularProgressIndicator())),
                                  ]else if(book.bookDataList.isEmpty)...[
                                    const Expanded(child: NoDataScreen())
                                  ]else...[
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: book.bookDataList.length,
                                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                          itemBuilder: (_, index){
                                            return BookWidget(bookModel: book.bookDataList[index], isList: true,);
                                          }),
                                    )
                                  ]
                                ]else if(item.id == 1)...[
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: saved.savedList.length,
                                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                        itemBuilder: (_, index){
                                          return BookWidget(bookModel: saved.savedList[index], isList: true,);
                                        }),
                                  )
                                ]else if(item.id == 2)...[
                                  if(book.isBookEmpty)...[
                                    const Expanded(child: Center(child: CircularProgressIndicator())),
                                  ]else if(book.bookDataList.isEmpty)...[
                                    const Expanded(child: NoDataScreen())
                                  ]else...[
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: book.bookDataList.length,
                                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                          itemBuilder: (_, index){
                                            return BookWidget(bookModel: book.bookDataList[index], isList: true,);
                                          }),
                                    )
                                  ]
                                ]else...[
                                  if(book.isBookEmpty)...[
                                    const Expanded(child: Center(child: CircularProgressIndicator())),
                                  ]else if(book.bookDataList.isEmpty)...[
                                    const Expanded(child: NoDataScreen())
                                  ]else...[
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: book.bookDataList.length,
                                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                          itemBuilder: (_, index){
                                            return BookWidget(bookModel: book.bookDataList[index], isList: true,);
                                          }),
                                    )
                                  ]
                                ]
                              ],
                            ),
                          );
                        }).toList()

                      ),
                    )),
              )
          ),
        ),
      ),
    );
  }
}

