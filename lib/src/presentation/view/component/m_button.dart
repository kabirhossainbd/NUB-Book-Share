import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isColor;
  final TextStyle? textStyle;
  final bool isLoader;
  const CustomButton({Key? key, required this.text, required this.onTap, this.isColor = true, this.textStyle, this.isLoader = false}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoader ? const Center(child: CircularProgressIndicator()): InkWell(
      onTap: widget.isColor ? widget.onTap : null,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.isColor ?  MyColor.getSecondaryColor() : MyColor.getDisableBgColor()
        ),
        child: Text(widget.text, style: widget.textStyle ?? robotoRegular.copyWith(color: widget.isColor ? MyColor.colorWhite : MyColor.getDisableColor(), fontSize: MySizes.fontSizeLarge),),
      ),
    );
  }
}