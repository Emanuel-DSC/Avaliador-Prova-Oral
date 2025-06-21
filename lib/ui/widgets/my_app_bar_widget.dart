import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? icon;
  final void Function()? onTap;

  const MyAppBar({super.key, this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              if (onTap != null) {
                onTap!();
              } else {
                Navigator.pop(context);
              }
            }),
        title: Text(
          title ?? 'GradEx',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
