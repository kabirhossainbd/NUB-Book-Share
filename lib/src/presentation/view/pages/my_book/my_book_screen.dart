import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/model/response/overview_model.dart';
import 'package:nub_book_sharing/src/presentation/view/component/book_widget.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_images.dart';

class MyBookScreen extends StatefulWidget {
  const MyBookScreen({super.key});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}

class _MyBookScreenState extends State<MyBookScreen> with SingleTickerProviderStateMixin{


  int _selectedIndex = 0;
  late TabController _mainTabController;
  final List<OverviewModel> _overviewList = [
    OverviewModel(id: 0, icon: MyImage.book, name: 'Continue Reading',itemCount: 210),
    OverviewModel(id: 1, icon: MyImage.favorite, name: 'Saved Items',itemCount: 20),
    OverviewModel(id: 2, icon: MyImage.openBook, name: 'Recently Read',itemCount: 310),
    OverviewModel(id: 3, icon: MyImage.download, name: 'Download Books',itemCount: 10),
  ];
  late ScrollController controller = ScrollController();
  String tabsModel = '';
  @override
  void initState() {
    Get.find<HomeController>().getBookList();
    _mainTabController = TabController(length: _overviewList.length, vsync: this, initialIndex: _selectedIndex);
    _mainTabController.addListener(()=> setState(() {
      _selectedIndex = _mainTabController.index;
    }));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
                            onTap: (index) => setState(() => _selectedIndex = index),
                            tabs: _overviewList.map((item){
                              int index = _overviewList.indexOf(item);
                              return Tab(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(item.icon ?? '', color: _selectedIndex == index ? MyColor.colorWhite : MyColor.colorHint,),
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
                      return  ListView.builder(
                        shrinkWrap: true,
                          itemCount: home.boolList.length,
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          itemBuilder: (_, index){
                            return BookWidget(bookModel: home.boolList[index], isList: true,);
                          });
                    }).toList(),
                  ),
                )),
          )
      ),
    );
  }
}

