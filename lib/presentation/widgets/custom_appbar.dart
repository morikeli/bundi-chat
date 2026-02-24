import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool? centerTitle;
  final Color? appBgColor;
  final TextStyle? appBarTitleStyle;
  // show icon button to navigate back to previous screen
  final bool goBackToPreviousScreen;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    this.goBackToPreviousScreen = false,
    this.actions,
    this.appBgColor,
    this.appBarTitleStyle,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 8.0,
      leading: goBackToPreviousScreen
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.back),
            )
          : null,
      automaticallyImplyLeading: goBackToPreviousScreen,
      backgroundColor: appBgColor,
      centerTitle: centerTitle,

      title: Text(
        appBarTitle,
        style: appBarTitleStyle ?? Theme.of(context).textTheme.titleMedium,
      ),

      actions: actions,
    );
  }
}
