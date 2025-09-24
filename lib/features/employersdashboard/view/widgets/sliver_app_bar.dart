import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class SliverAppbarr extends StatelessWidget {
  const SliverAppbarr({
    super.key,
    required AnimationController animationController,
    required this.title,
  }) : _animationController = animationController;

  final AnimationController _animationController;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title:  Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
          },
        ),
      ],
    );
  }
}
