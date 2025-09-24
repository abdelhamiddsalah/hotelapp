import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class PendingReservationsView extends StatefulWidget {
  const PendingReservationsView({super.key});

  @override
  State<PendingReservationsView> createState() => _PendingReservationsViewState();
}

class _PendingReservationsViewState extends State<PendingReservationsView> {
  // بيانات تجريبية
  List<Map<String, dynamic>> pendingReservations = [
    {
      'guestName': 'Ali Ahmed',
      'checkIn': '2025-09-25',
      'checkOut': '2025-09-28',
      'room': 'Not Assigned',
    },
    {
      'guestName': 'Sara Mohamed',
      'checkIn': '2025-09-26',
      'checkOut': '2025-09-27',
      'room': '205',
    },
  ];

  void _acceptReservation(int index) {
    setState(() {
      pendingReservations.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reservation Accepted ✅')),
    );
  }

  void _rejectReservation(int index) {
    setState(() {
      pendingReservations.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reservation Rejected ❌')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Pending Reservations',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: pendingReservations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pendingReservations.length,
              itemBuilder: (context, index) {
                final reservation = pendingReservations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reservation['guestName'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Check-in: ${reservation['checkIn']}"),
                        Text("Check-out: ${reservation['checkOut']}"),
                        Text("Room: ${reservation['room']}"),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => _rejectReservation(index),
                              icon: const Icon(Icons.close, color: Colors.red),
                              label: const Text(
                                "Reject",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () => _acceptReservation(index),
                              icon: const Icon(Icons.check, color: Colors.white),
                              label: const Text("Accept"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No Pending Reservations",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "All reservations are up to date 🎉",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
