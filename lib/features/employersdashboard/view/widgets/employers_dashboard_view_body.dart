import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/actions_in_employers_das.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/wlecome_section.dart';

class EmployersDashboardViewBody extends StatefulWidget {
  const EmployersDashboardViewBody({super.key});

  @override
  State<EmployersDashboardViewBody> createState() =>
      _EmployersDashboardViewBodyState();
}

class _EmployersDashboardViewBodyState
    extends State<EmployersDashboardViewBody> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text(
          'Employee Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildDashboardContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.add, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.secondaryColor,
                  child: const Icon(
                    Icons.person,
                    size: 35,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'John Smith',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Front Desk Manager',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
          _buildDrawerItem(Icons.bed, 'Rooms', 1),
          _buildDrawerItem(Icons.people, 'Guests', 2),
          _buildDrawerItem(Icons.calendar_today, 'Reservations', 3),
          _buildDrawerItem(Icons.cleaning_services, 'Housekeeping', 4),
          _buildDrawerItem(Icons.bar_chart, 'Reports', 5),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Logout', 6),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedIndex == index
            ? AppColors.secondaryColor
            : Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selectedIndex == index
              ? AppColors.primaryColor
              : Colors.grey[800],
          fontWeight: selectedIndex == index
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      selected: selectedIndex == index,
      selectedTileColor: AppColors.secondaryColor.withOpacity(0.1),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeSection(),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 24),
            ActionsInEmployersDas(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Total Rooms', '50', Icons.bed, Colors.blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Available',
            '50',
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Occupied', '0', Icons.person, Colors.orange),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
