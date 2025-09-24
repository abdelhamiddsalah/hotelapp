import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cleaning_services,
              size: 80,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            text1,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            text2,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
