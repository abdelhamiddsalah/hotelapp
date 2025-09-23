import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class EmployerAuthButton extends StatelessWidget {
  const EmployerAuthButton({
    super.key,
    required this.onPressed,
    required this.title,
  });
final  void Function()? onPressed;
  final String title ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.backgroundColor,
          elevation: 8,
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child:Text(
              title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
