import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isPassword;
  final bool passwordVisible;
  final VoidCallback? onPasswordToggle;
  final bool? readOnly;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
    
  

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.isPassword = false,
    this.passwordVisible = false,
    this.onPasswordToggle,
    this.readOnly,
    this.onTap,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: isPassword ? !passwordVisible : false,
        decoration: InputDecoration(
  hintText: hint,
  hintStyle: const TextStyle(color: AppColors.borderColor),
  prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
  suffixIcon: isPassword
      ? IconButton(
          onPressed: onPasswordToggle,
          icon: Icon(
            passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryColor,
            size: 20,
          ),
        )
      : null,
  filled: true,
  fillColor: AppColors.secondaryColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.borderColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.borderColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: AppColors.primaryColor,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.errorColor),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
),
          readOnly: readOnly ?? false,
          onTap: onTap,
        ),
      ],
    );
  }
}
