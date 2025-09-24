import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
      ),
    );
  }

  

   Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.amber;
      case 'Checked-in':
        return Colors.green;
      case 'Checked-out':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.schedule;
      case 'Checked-in':
        return Icons.login;
      case 'Checked-out':
        return Icons.logout;
      default:
        return Icons.help_outline;
    }
  }

  Color getGuestTypeColor(String guestType) {
    switch (guestType) {
      case 'VIP':
        return Colors.purple;
      case 'Premium':
        return Colors.blue;
      default:
        return Colors.grey;
    }

    
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // بيانات تجريبية محسنة
  List<Map<String, dynamic>> rooms = [
    {
      'room': '101',
      'status': 'Dirty',
      'floor': '1',
      'type': 'Standard',
      'priority': 'High',
      'assignedTo': 'Sara Ahmed',
      'lastCleaned': '2025-09-23',
      'estimatedTime': '45 min',
    },
    {
      'room': '102',
      'status': 'Clean',
      'floor': '1',
      'type': 'Deluxe',
      'priority': 'Medium',
      'assignedTo': 'Nour Hassan',
      'lastCleaned': '2025-09-24',
      'estimatedTime': '30 min',
    },
    {
      'room': '103',
      'status': 'Dirty',
      'floor': '1',
      'type': 'Suite',
      'priority': 'High',
      'assignedTo': 'Fatma Ali',
      'lastCleaned': '2025-09-22',
      'estimatedTime': '60 min',
    },
    {
      'room': '104',
      'status': 'Maintenance',
      'floor': '1',
      'type': 'Standard',
      'priority': 'High',
      'assignedTo': 'Ahmed Khaled',
      'lastCleaned': '2025-09-20',
      'estimatedTime': '90 min',
    },
    {
      'room': '201',
      'status': 'In Progress',
      'floor': '2',
      'type': 'Deluxe',
      'priority': 'Medium',
      'assignedTo': 'Mona Sayed',
      'lastCleaned': '2025-09-24',
      'estimatedTime': '20 min',
    },
    {
      'room': '202',
      'status': 'Dirty',
      'floor': '2',
      'type': 'Standard',
      'priority': 'Low',
      'assignedTo': 'Hala Omar',
      'lastCleaned': '2025-09-23',
      'estimatedTime': '45 min',
    },
  ];








 List<Map<String, dynamic>> issues = [
    {
      'room': '201',
      'issue': 'Air Conditioner not working',
      'status': 'Pending',
      'priority': 'High',
      'category': 'HVAC',
      'reportedBy': 'Reception',
      'assignedTo': 'Ahmed Tech',
      'reportedDate': '2025-09-23',
      'estimatedTime': '2 hours',
      'description': 'Guest complained that AC is not cooling properly. Needs immediate attention.',
      'cost': '\$150'
    },
    {
      'room': '305',
      'issue': 'Water leakage in bathroom',
      'status': 'In Progress',
      'priority': 'High',
      'category': 'Plumbing',
      'reportedBy': 'Housekeeping',
      'assignedTo': 'Omar Plumber',
      'reportedDate': '2025-09-22',
      'estimatedTime': '3 hours',
      'description': 'Water leaking from shower head and pipe connections.',
      'cost': '\$200'
    },
    {
      'room': '410',
      'issue': 'Broken TV',
      'status': 'Completed',
      'priority': 'Medium',
      'category': 'Electronics',
      'reportedBy': 'Guest',
      'assignedTo': 'Sara Electronics',
      'reportedDate': '2025-09-21',
      'estimatedTime': '1 hour',
      'description': 'TV screen is cracked and not displaying properly.',
      'cost': '\$300'
    },
    {
      'room': '102',
      'issue': 'Door lock malfunction',
      'status': 'Pending',
      'priority': 'High',
      'category': 'Security',
      'reportedBy': 'Security',
      'assignedTo': 'Khaled Security',
      'reportedDate': '2025-09-24',
      'estimatedTime': '45 min',
      'description': 'Electronic door lock is not responding to key cards.',
      'cost': '\$80'
    },
    {
      'room': '508',
      'issue': 'Light fixture replacement',
      'status': 'In Progress',
      'priority': 'Low',
      'category': 'Electrical',
      'reportedBy': 'Housekeeping',
      'assignedTo': 'Mostafa Electric',
      'reportedDate': '2025-09-20',
      'estimatedTime': '30 min',
      'description': 'Ceiling light is flickering and needs replacement.',
      'cost': '\$50'
    },
  ];
