import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class LastRowInAuth extends StatelessWidget {
  const LastRowInAuth({super.key, this.onPressed, required this.text1, required this.text2});
  final void Function()? onPressed;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            text: text1,
            style: TextStyle(
              color: AppColors.textColor.withOpacity(0.6),
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text:text2,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
