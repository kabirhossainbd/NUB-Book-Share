import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/presentation/view/component/custom_image.dart';

class ProfileAvatar extends StatefulWidget {
  final String url;
  final double width, height;
  const ProfileAvatar({super.key, required this.url, this.width = 50, this.height = 50});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return  ClipOval(
      child: CustomImageDemo(
        url: widget.url,
        height: widget.height,
        width: widget.width,
        shimmerEnable: false,
      ),
    );
  }
}
