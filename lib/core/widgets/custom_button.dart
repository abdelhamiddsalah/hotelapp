import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool isSecondary;

  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildButton(
      text: text,
      color: color,
      onPressed: () {
        onPressed();
        if (!isSecondary) {
          FocusScope.of(context).unfocus();
        }
      },
      isSecondary: isSecondary,
    );
  }
}


Widget _buildButton({
  required String text,
  required Color color,
  required VoidCallback onPressed,
  bool isSecondary = false,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: isSecondary ? Colors.transparent : color,
      foregroundColor: isSecondary ? color : Colors.white,
      side: isSecondary ? BorderSide(color: color) : null,
      padding: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: isSecondary ? 0 : 3,
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}

