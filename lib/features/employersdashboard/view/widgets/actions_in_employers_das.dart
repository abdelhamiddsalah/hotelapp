import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/card_in_employers_das.dart';

class ActionsInEmployersDas extends StatelessWidget {
  const ActionsInEmployersDas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Quick Actions',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: CardInEmployersDashboard(
              title: 'Pending Reservations',
              icon: Icons.pending_actions,
              color: Colors.orange,
              onTap: () {
                context.go(Routes.pendingReservations);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CardInEmployersDashboard(
              title: 'Check-in / Check-out',
              icon: Icons.login,
              color: Colors.green,
              onTap: () {
                context.go(Routes.checkoutIn);
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
        Row(
        children: [
          Expanded(
            child: CardInEmployersDashboard(
              title: 'Add Room',
              icon: Icons.room_outlined,
              color: Colors.orange,
              onTap: () {
                context.go(Routes.addRoom);
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: CardInEmployersDashboard(
              title: 'Housekeeping',
              icon: Icons.cleaning_services,
              color: Colors.blue,
              onTap: () {
                context.go(Routes.housekeeping);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CardInEmployersDashboard(
              title: 'Maintenance',
              icon: Icons.build,
              color: Colors.red,
              onTap: () {
                context.go(Routes.maintenance);
              },
            ),
          ),
        ],
      ),
    ],
  );
  }
}