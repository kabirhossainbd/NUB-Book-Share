import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/main_menu.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/page_structure.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _drawerController = ZoomDrawerController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: MenuScreen(
        callback: _updatePage,
        current: _currentPage,
        controller: _drawerController,
      ),
      mainScreen: const MainScreen(),
      openCurve: Curves.fastOutSlowIn,
      showShadow: false,
      slideWidth: MediaQuery.of(context).size.width * (0.65),
      mainScreenTapClose: true,
      mainScreenOverlayColor: Colors.brown.withOpacity(0.5),
      borderRadius: 10,
      angle: 0.0,
      menuScreenWidth: double.infinity,
      moveMenuScreen: false,
      style: DrawerStyle.defaultStyle,
      drawerShadowsBackgroundColor: Colors.yellow,
      mainScreenAbsorbPointer: false,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  void _updatePage(int index) {
    if (index == _currentPage) return;
    _currentPage = index;
    _drawerController.toggle?.call();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (context, state, child) {
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: const PageStructure(),
    );
  }
}
