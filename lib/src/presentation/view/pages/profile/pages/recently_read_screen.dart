import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';

class RecentlyReadScreen extends StatefulWidget {
  const RecentlyReadScreen({super.key});

  @override
  State<RecentlyReadScreen> createState() => _RecentlyReadScreenState();
}

class _RecentlyReadScreenState extends State<RecentlyReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: 'Saved Item',),
      body: const SafeArea(
        child: Center(
            child: NoDataScreen()
        ),
      ),
    );
  }
}
