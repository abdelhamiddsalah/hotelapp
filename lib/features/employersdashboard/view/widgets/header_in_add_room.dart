
import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class HeaderInAddRoom extends StatelessWidget {
  const HeaderInAddRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.hotel,
          size: 50,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 10),
        Text(
          'Room Registration Form',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Fill in the details to add a new room to the hotel',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
