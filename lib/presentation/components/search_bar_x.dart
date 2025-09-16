import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_investment_app/presentation/assets/asset_index.dart';

class SearchBarX extends StatefulWidget {
  const SearchBarX({
    super.key,
    required this.onChanged,
    required this.controller,
    this.hintText,
    this.fillColor,
    this.autoFocus = false,
    this.keyboardType,
    this.isLoading = false,
    this.onClearPressed,
  });

  final ValueChanged<String> onChanged;
  final String? hintText;
  final TextEditingController controller;
  final Color? fillColor;
  final bool autoFocus;
  final TextInputType? keyboardType;
  final bool isLoading;
  final VoidCallback? onClearPressed;

  @override
  State<SearchBarX> createState() => _SearchBarXState();
}

class _SearchBarXState extends State<SearchBarX> {
  final borderTheme = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(12.r),
  );

  bool showCloseIcon = false;

  @override
  Widget build(BuildContext context) {
    // final colors = ;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: BaseColors.borderColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        style: AppTextStyles.caption.copyWith(color: BaseColors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenSize.w16,
            vertical: ScreenSize.h8,
          ),
          prefixIcon: Padding(
            padding:
                EdgeInsets.only(left: ScreenSize.w12, right: ScreenSize.w8),
            child: Icon(
              CupertinoIcons.search,
              color: BaseColors.black,
              size: 20.sp,
            ),
          ),
          focusedBorder: borderTheme,
          enabledBorder: borderTheme,
          border: borderTheme,
          errorBorder: borderTheme,
          hintText: widget.hintText ?? 'Search',
          hintStyle: AppTextStyles.caption,
          fillColor: widget.fillColor ?? BaseColors.borderColor,
          suffixIcon: getSuffixIcon(),
        ),
        onChanged: (v) {
          if (widget.controller.text.isEmpty) {
            updateCloseIconValue(false);
          } else if (widget.controller.text.isNotEmpty && !showCloseIcon) {
            updateCloseIconValue(true);
          }
          widget.onChanged.call(v);
        },
      ),
    );
  }

  void updateCloseIconValue(bool value) {
    setState(() => showCloseIcon = value);
  }

  Widget getSuffixIcon() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: showCloseIcon ? 1.0 : 0.0,
      child: IconButton(
        onPressed: showCloseIcon
            ? () {
                updateCloseIconValue(false);
                widget.controller.clear();
                widget.onClearPressed?.call();
              }
            : null,
        icon: Icon(
          Icons.close,
          size: 20.sp,
          color: BaseColors.black,
        ),
      ),
    );
  }
}
