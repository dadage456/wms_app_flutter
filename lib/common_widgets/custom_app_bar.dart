import 'package:flutter/material.dart';

const TextStyle _appBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

class CustomAppBar {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
  });

  AppBar get appBar {
    return AppBar(
      backgroundColor: const Color(0xFF1976D2),
      centerTitle: true,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onBackPressed,
            )
          : null,
      title: Text(title, textAlign: TextAlign.center, style: _appBarTextStyle),
      actions: actions,
    );
  }
}
