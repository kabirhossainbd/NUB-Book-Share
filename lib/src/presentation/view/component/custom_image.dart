
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageDemo extends StatefulWidget {
  final String url;
  final double height, width;
  final bool shimmerEnable;
  const CustomImageDemo({super.key, required this.url, this.height = 120, this.width = 200, this.shimmerEnable = false});

  @override
  State<CustomImageDemo> createState() => _CustomImageDemoState();
}

class _CustomImageDemoState extends State<CustomImageDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3), lowerBound: 0.0, upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final String url = 'https://photo.tuchong.com/4870004/f/298584322.jpg';
    return ExtendedImage.network(
      widget.url,
      fit: BoxFit.cover,
      width: widget.width,
      height: widget.height,
      cache: true,
      clearMemoryCacheWhenDispose: false,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            return SizedBox(
              width: widget.width,
              height: widget.height,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  color: Colors.grey[200],
                ),
              )
            );
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              return state.completedWidget;
            }
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: state.completedWidget,
            );
          case LoadState.failed:
            _controller.reset();
            //remove memory cached
            state.imageProvider.evict();
            return Shimmer.fromColors(
              enabled: widget.shimmerEnable,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                color: Colors.grey[200],
              ),
            );
        }
      },
    );
  }
}