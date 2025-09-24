import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/widgets/empty_state.dart';
import 'package:hotelapp/core/widgets/messaes.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/sliver_app_bar.dart';

class HousekeepingView extends StatefulWidget {
  const HousekeepingView({super.key});

  @override
  State<HousekeepingView> createState() => _HousekeepingViewState();
}

class _HousekeepingViewState extends State<HousekeepingView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _markAsClean(int index) {
    setState(() {
      rooms[index]['status'] = 'Clean';
      rooms[index]['lastCleaned'] = '2025-09-24';
    });
  }

  void _markInProgress(int index) {
    setState(() {
      rooms[index]['status'] = 'In Progress';
    });
  }

  void _markForMaintenance(int index) {
    setState(() {
      rooms[index]['status'] = 'Maintenance';
    });
  }

  List<Map<String, dynamic>> _getFilteredRooms() {
    if (_selectedFilter == 'All') return rooms;
    return rooms.where((room) => room['status'] == _selectedFilter).toList();
  }

  Map<String, int> _getStatusCounts() {
    Map<String, int> counts = {
      'Clean': 0,
      'Dirty': 0,
      'In Progress': 0,
      'Maintenance': 0,
    };
    for (var room in rooms) {
      counts[room['status']] = (counts[room['status']] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final filteredRooms = _getFilteredRooms();
    final statusCounts = _getStatusCounts();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppbarr(
            animationController: _animationController,
            title: 'Housekeeping',
          ),
          SliverToBoxAdapter(child: _buildStatusOverview(statusCounts)),
          SliverToBoxAdapter(child: _buildFilterChips()),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: filteredRooms.isEmpty
                ? SliverFillRemaining(
                    child: EmptyState(
                      text1: "No Rooms Found",
                      text2: "No rooms match the selected filter",
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: Interval(
                                    index * 0.1,
                                    1.0,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                              ),
                          child: _buildRoomCard(filteredRooms[index], index),
                        ),
                      ),
                      childCount: filteredRooms.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOverview(Map<String, int> counts) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Status Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard(
                  'Clean',
                  counts['Clean']!,
                  Colors.green,
                  Icons.check_circle,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatusCard(
                  'Dirty',
                  counts['Dirty']!,
                  Colors.red,
                  Icons.cleaning_services,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatusCard(
                  'In Progress',
                  counts['In Progress']!,
                  Colors.blue,
                  Icons.hourglass_top,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatusCard(
                  'Maintenance',
                  counts['Maintenance']!,
                  Colors.orange,
                  Icons.build,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Dirty', 'Clean', 'In Progress', 'Maintenance'];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primaryColor.withOpacity(0.1),
              checkmarkColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey[300]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.black.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey[50]!],
            ),
            border: Border.all(
              color: getStatusColor(room['status']).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoomHeader(room),
                const SizedBox(height: 16),
                _buildRoomDetails(room),
                const SizedBox(height: 16),
                _buildRoomActions(room, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomHeader(Map<String, dynamic> room) {
    return Row(
      children: [
        Hero(
          tag: 'room_${room['room']}',
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: getStatusColor(room['status']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: getStatusColor(room['status']).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  getStatusIcon(room['status']),
                  color: getStatusColor(room['status']),
                  size: 20,
                ),
                Text(
                  room['room'],
                  style: TextStyle(
                    color: getStatusColor(room['status']),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Room ${room['room']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Floor ${room['floor']}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      room['type'],
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getPriorityColor(
                        room['priority'],
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${room['priority']} Priority',
                      style: TextStyle(
                        color: getPriorityColor(room['priority']),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: getStatusColor(room['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            room['status'],
            style: TextStyle(
              color: getStatusColor(room['status']),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomDetails(Map<String, dynamic> room) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.person,
                  "Assigned to",
                  room['assignedTo'],
                  Colors.purple,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey[300]),
              Expanded(
                child: _buildDetailItem(
                  Icons.access_time,
                  "Est. Time",
                  room['estimatedTime'],
                  Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: _buildDetailItem(
              Icons.calendar_today,
              "Last Cleaned",
              room['lastCleaned'],
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRoomActions(Map<String, dynamic> room, int index) {
    final status = room['status'];

    if (status == 'Dirty') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _markInProgress(index),
              icon: Icon(Icons.play_arrow),
              label: Text('Start Cleaning'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _markForMaintenance(index),
              icon: Icon(Icons.build),
              label: Text('Maintenance'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (status == 'In Progress') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _markAsClean(index),
          icon: Icon(Icons.check_circle),
          label: Text('Mark as Clean'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == 'Clean' ? Icons.check_circle : Icons.build,
              color: Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              status == 'Clean' ? 'Room is Clean' : 'Under Maintenance',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
  }
}
