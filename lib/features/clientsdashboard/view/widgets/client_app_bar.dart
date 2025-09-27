
import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class ClientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      title: Text(
        'Golden Dreams Hotel',
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: AppColors.secondaryColor),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.person, color: AppColors.secondaryColor),
          onPressed: () {},
        ),
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
