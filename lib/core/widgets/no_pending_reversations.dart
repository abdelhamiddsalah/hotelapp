import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class NoPendingReservations extends StatelessWidget {
  const NoPendingReservations({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
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
              Icons.event_busy,
              size: 80,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "No Pending Reservations",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "All guests are checked-in or checked-out! 🎉",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // يمكن إضافة وظيفة إضافة حجز جديد هنا
            },
            icon: const Icon(Icons.add),
            label: const Text("Add New Reservation"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}