import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';


class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final bool isbBorderColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool? isPassword;
  final bool? isCountryPicker;
  final bool? isShowBorder;
  final bool? isIcon;
  final bool? isShowSuffixIcon;
  final bool? isShowPrefixIcon;
  final Function? onTap;
  final Function(String text)? onChanged;
  final Function? onSuffixTap;
  final String? suffixActiveIconUrl;
  final String? suffixInactiveIconUrl;
  final String? prefixIconUrl;
  final Widget prefixWidget;
  final bool? isSearch;
  final Function? onSubmit;
  final bool? isEnabled;
  final TextCapitalization? capitalization;

  const CustomTextField(
      {Key? key,
        this.title,
        this.hintText = 'Write something...',
        this.controller,
        this.borderRadius,
        this.backgroundColor,
        this.isbBorderColor = false,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines,
        this.maxLength,
        this.maxLengthEnforcement,
        this.onSuffixTap,
        this.fillColor,
        this.onSubmit,
        this.onChanged,
        this.capitalization = TextCapitalization.none,
        this.isCountryPicker = false,
        this.isShowBorder = false,
        this.isShowSuffixIcon = false,
        this.isShowPrefixIcon = false,
        this.prefixWidget = const SizedBox(),
        this.onTap,
        this.isIcon = false,
        this.isPassword = false,
        this.suffixActiveIconUrl,
        this.suffixInactiveIconUrl,
        this.prefixIconUrl,
        this.isSearch = false,}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxLines == null ?  44 : null,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(color: widget.isbBorderColor ? Colors.grey : Colors.transparent)
      ),
      child: TextField(
        textAlign: TextAlign.start,
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: widget.capitalization!,
        enabled: widget.isEnabled,
        autofocus: false,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLength: widget.maxLength,
        //onChanged: page.isSearch ? page.languageProvider.searchLanguage : null,
        obscureText: widget.isIcon! ? _obscureText : false,
        inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
        decoration: InputDecoration(
         // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
         border: InputBorder.none,
          isDense: true,
          hintText: widget.hintText,
          fillColor: widget.fillColor,
          hintStyle: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.colorHint),
          filled: true,
          contentPadding: const EdgeInsets.only(left:8,top: 0),
          prefix: widget.prefixWidget,
          //prefixIcon: widget.isShowPrefixIcon! ? SvgPicture.asset(widget.prefixIconUrl!) : const SizedBox.shrink(),
          prefixIconConstraints: const BoxConstraints(minWidth: 8, maxHeight: 20),
          suffixIcon: widget.isShowSuffixIcon!
              ? widget.isPassword! ? IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.getGreyColor()),
              onPressed: _toggle)
              : widget.isIcon!
              ? IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onPressed:_toggle,
            icon: SvgPicture.asset(
              _obscureText ? widget.suffixInactiveIconUrl! : widget.suffixActiveIconUrl!,
              width: 18,
              height: 13,
            ),
          ) : null
              : null,
        ),
        onTap: () => widget.onTap,
        onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : widget.onSubmit != null ? widget.onSubmit!(text) : null,
        onChanged: (text) {
          widget.onChanged != null ? widget.onChanged!(text) : {};
          // if (text.isNotEmpty && !Get.find<AuthController>().isCursorButtonActive) {
          //   Get.find<AuthController>().toggleCursorButtonActivity();
          // } else if (text.isEmpty && Get.find<AuthController>().isCursorButtonActive) {
          //   Get.find<AuthController>().toggleCursorButtonActivity();
          // }
        },
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}




class CustomTextFieldWithLevel extends StatefulWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final bool isbBorderColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool? isPassword;
  final bool? isCountryPicker;
  final bool? isShowBorder;
  final bool? isIcon;
  final bool? isShowSuffixIcon;
  final bool? isShowPrefixIcon;
  final Widget? onSuffixIcon;
  final Function? onTap;
  final Function(String text)? onChanged;
  final Function? onSuffixTap;
  final String? suffixActiveIconUrl;
  final String? suffixInactiveIconUrl;
  final String? prefixIconUrl;
  final Widget prefixWidget;
  final bool? isSearch;
  final Function? onSubmit;
  final bool? isEnabled;
  final TextCapitalization? capitalization;
  final TextAlign alignment;

  const CustomTextFieldWithLevel(
      {Key? key,
        this.title,
        this.hintText = 'Write something...',
        this.controller,
        this.borderRadius,
        this.backgroundColor,
        this.isbBorderColor = false,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.maxLength,
        this.maxLengthEnforcement,
        this.onSuffixTap,
        this.fillColor,
        this.onSubmit,
        this.onChanged,
        this.capitalization = TextCapitalization.none,
        this.isCountryPicker = false,
        this.isShowBorder = false,
        this.isShowSuffixIcon = false,
        this.isShowPrefixIcon = false,
        this.onSuffixIcon,
        this.prefixWidget = const SizedBox(),
        this.onTap,
        this.isIcon = false,
        this.isPassword = false,
        this.suffixActiveIconUrl,
        this.suffixInactiveIconUrl,
        this.prefixIconUrl,
        this.isSearch = false,
        this.alignment = TextAlign.center,
      }) : super(key: key);

  @override
  State<CustomTextFieldWithLevel> createState() => _CustomTextFieldWithLevelState();
}

class _CustomTextFieldWithLevelState extends State<CustomTextFieldWithLevel> {

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: widget.alignment,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: robotoRegular.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: false,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLength: widget.maxLength,
      obscureText: widget.isIcon! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: MyColor.getGreyColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: MyColor.getGreyColor()),
        ),
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        hintStyle: robotoRegular.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.colorGrey),
        filled: true,
        focusColor: MyColor.getPrimaryColor(),
        labelText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: TextStyle(color: MyColor.getPrimaryColor()),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.only(left:8,top: 6, bottom: 6),
        prefix: widget.prefixWidget,
        //prefixIcon: widget.isShowPrefixIcon! ? SvgPicture.asset(widget.prefixIconUrl!) : const SizedBox.shrink(),
        prefixIconConstraints: const BoxConstraints(minWidth: 8, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon!
            ? widget.onSuffixIcon
            : widget.isIcon!
            ? IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onPressed:_toggle,
          icon: SvgPicture.asset(
            _obscureText ? widget.suffixInactiveIconUrl! : widget.suffixActiveIconUrl!,
            width: 18,
            height: 13,
          ),
        ) : null,
      ),
      onTap: () => widget.onTap,
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: (text) {
        widget.onChanged != null ? widget.onChanged!(text) : {};
        // if (text.isNotEmpty && !Get.find<AuthController>().isCursorButtonActive) {
        //   Get.find<AuthController>().toggleCursorButtonActivity();
        // } else if (text.isEmpty && Get.find<AuthController>().isCursorButtonActive) {
        //   Get.find<AuthController>().toggleCursorButtonActivity();
        // }
      },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}