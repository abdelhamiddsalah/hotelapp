
import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class HeaderInClientAuth extends StatelessWidget {
  const HeaderInClientAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_add_outlined,
              size: 40,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Join Grand Hotel',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your account to book luxury stays',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
