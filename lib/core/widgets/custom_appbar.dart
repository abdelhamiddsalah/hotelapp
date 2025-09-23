import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
