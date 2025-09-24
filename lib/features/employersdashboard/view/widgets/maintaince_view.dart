import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

class MaintenanceView extends StatefulWidget {
  const MaintenanceView({super.key});

  @override
  State<MaintenanceView> createState() => _MaintenanceViewState();
}

class _MaintenanceViewState extends State<MaintenanceView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedFilter = 'All';

  // بيانات تجريبية محسنة
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      issues[index]['status'] = newStatus;
    });
    _showCustomSnackBar('Issue ${issues[index]['room']} updated to $newStatus! 🔧', _getStatusColor(newStatus));
  }

  void _showIssueDetails(Map<String, dynamic> issue) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildIssueDetailsModal(issue),
    );
  }

  void _showCustomSnackBar(String message, Color color) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.red;
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.schedule;
      case 'In Progress':
        return Icons.engineering;
      case 'Completed':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  Color _getPriorityColor(String priority) {
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'HVAC':
        return Colors.blue;
      case 'Plumbing':
        return Colors.cyan;
      case 'Electronics':
        return Colors.purple;
      case 'Security':
        return Colors.red;
      case 'Electrical':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'HVAC':
        return Icons.ac_unit;
      case 'Plumbing':
        return Icons.plumbing;
      case 'Electronics':
        return Icons.tv;
      case 'Security':
        return Icons.security;
      case 'Electrical':
        return Icons.electrical_services;
      default:
        return Icons.build;
    }
  }

  List<Map<String, dynamic>> _getFilteredIssues() {
    if (_selectedFilter == 'All') return issues;
    return issues.where((issue) => issue['status'] == _selectedFilter).toList();
  }

  Map<String, int> _getStatusCounts() {
    Map<String, int> counts = {
      'Pending': 0,
      'In Progress': 0,
      'Completed': 0,
    };
    for (var issue in issues) {
      counts[issue['status']] = (counts[issue['status']] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final filteredIssues = _getFilteredIssues();
    final statusCounts = _getStatusCounts();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: _buildStatusOverview(statusCounts),
          ),
          SliverToBoxAdapter(
            child: _buildFilterChips(),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: filteredIssues.isEmpty
                ? SliverFillRemaining(child: _buildEmptyState())
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index * 0.1,
                              1.0,
                              curve: Curves.easeOutCubic,
                            ),
                          )),
                          child: _buildIssueCard(filteredIssues[index], index),
                        ),
                      ),
                      childCount: filteredIssues.length,
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddIssueDialog,
        backgroundColor: AppColors.primaryColor,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Add Issue', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Maintenance',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
          },
        ),
      ],
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
            'Maintenance Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatusCard('Pending', counts['Pending']!, Colors.red, Icons.schedule)),
              SizedBox(width: 12),
              Expanded(child: _buildStatusCard('In Progress', counts['In Progress']!, Colors.orange, Icons.engineering)),
              SizedBox(width: 12),
              Expanded(child: _buildStatusCard('Completed', counts['Completed']!, Colors.green, Icons.check_circle)),
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Pending', 'In Progress', 'Completed'];
    
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
                  color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showIssueDetails(issue),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey[50]!,
                ],
              ),
              border: Border.all(
                color: _getStatusColor(issue['status']).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIssueHeader(issue),
                  const SizedBox(height: 16),
                  _buildIssueDetails(issue),
                  const SizedBox(height: 16),
                  _buildIssueActions(issue, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIssueHeader(Map<String, dynamic> issue) {
    return Row(
      children: [
        Hero(
          tag: 'issue_${issue['room']}',
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: _getCategoryColor(issue['category']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _getCategoryColor(issue['category']).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              _getCategoryIcon(issue['category']),
              color: _getCategoryColor(issue['category']),
              size: 24,
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
                    'Room ${issue['room']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(issue['priority']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${issue['priority']} Priority',
                      style: TextStyle(
                        fontSize: 10,
                        color: _getPriorityColor(issue['priority']),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                issue['issue'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(issue['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  issue['category'],
                  style: TextStyle(
                    color: _getCategoryColor(issue['category']),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(issue['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getStatusIcon(issue['status']),
                size: 16,
                color: _getStatusColor(issue['status']),
              ),
              const SizedBox(width: 6),
              Text(
                issue['status'],
                style: TextStyle(
                  color: _getStatusColor(issue['status']),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIssueDetails(Map<String, dynamic> issue) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildDetailItem(
              Icons.person,
              "Assigned to",
              issue['assignedTo'],
              Colors.purple,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          Expanded(
            child: _buildDetailItem(
              Icons.access_time,
              "Est. Time",
              issue['estimatedTime'],
              Colors.orange,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          Expanded(
            child: _buildDetailItem(
              Icons.attach_money,
              "Cost",
              issue['cost'],
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value, Color color) {
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

  Widget _buildIssueActions(Map<String, dynamic> issue, int index) {
    return Row(
      children: [
        if (issue['status'] == 'Pending') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _updateStatus(index, 'In Progress'),
              icon: Icon(Icons.play_arrow),
              label: Text('Start Work'),
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
        ] else if (issue['status'] == 'In Progress') ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _updateStatus(index, 'Completed'),
              icon: Icon(Icons.check_circle),
              label: Text('Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: PopupMenuButton<String>(
            onSelected: (value) => _updateStatus(index, value),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Pending',
                child: Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Text('Pending'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'In Progress',
                child: Row(
                  children: [
                    Icon(Icons.engineering, color: Colors.orange, size: 20),
                    SizedBox(width: 12),
                    Text('In Progress'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Completed',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 12),
                    Text('Completed'),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.more_vert, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIssueDetailsModal(Map<String, dynamic> issue) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(issue['category']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              _getCategoryIcon(issue['category']),
                              color: _getCategoryColor(issue['category']),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Room ${issue['room']}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  issue['category'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _getCategoryColor(issue['category']),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Issue Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        issue['issue'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        issue['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildDetailRow('Priority', issue['priority'], _getPriorityColor(issue['priority'])),
                      _buildDetailRow('Status', issue['status'], _getStatusColor(issue['status'])),
                      _buildDetailRow('Reported By', issue['reportedBy'], Colors.blue),
                      _buildDetailRow('Assigned To', issue['assignedTo'], Colors.purple),
                      _buildDetailRow('Reported Date', issue['reportedDate'], Colors.grey),
                      _buildDetailRow('Estimated Time', issue['estimatedTime'], Colors.orange),
                      _buildDetailRow('Estimated Cost', issue['cost'], Colors.green),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
              Icons.build,
              size: 80,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "No Issues Found",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "No maintenance issues match the selected filter",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddIssueDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Issue'),
        content: Text('This feature would open a form to add new maintenance issues.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Add Issue'),
          ),
        ],
      ),
    );
  }
}