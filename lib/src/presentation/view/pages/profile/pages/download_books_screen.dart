import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/no_data_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';

class DownloadBookScreen extends StatefulWidget {
  const DownloadBookScreen({super.key});

  @override
  State<DownloadBookScreen> createState() => _DownloadBookScreenState();
}

class _DownloadBookScreenState extends State<DownloadBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: 'Download Books',),
      body: const SafeArea(
        child: Center(
            child: NoDataScreen()
        ),
      ),
    );
  }
}
