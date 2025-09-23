import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/core/styling/colors.dart';

class UserchoiceView extends StatelessWidget {
  const UserchoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Section
                  SizedBox(height: screenHeight * 0.05),

                  // Hotel Icon/Logo
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.hotel,
                      size: screenWidth * 0.15,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Welcome Text
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Text(
                    'Choose your account type to continue',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: AppColors.primaryColor.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: screenHeight * 0.06),

                  // Choice Cards Section
                  _buildChoiceCard(
                    context: context,
                    title: 'Client',
                    subtitle: 'Looking for hotel services',
                    icon: Icons.person,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: () {
                      context.go(Routes.clientLogin);
                    },
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  _buildChoiceCard(
                    context: context,
                    title: 'Employee',
                    subtitle: 'Working at the hotel',
                    icon: Icons.work,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTap: () {
                      context.go(Routes.employerLogin);
                    },
                  ),

                  SizedBox(height: screenHeight * 0.06),

                  // Footer Section
                  Text(
                    'Hotel Management App',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: AppColors.primaryColor.withOpacity(0.5),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Container(
                    height: 3,
                    width: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.9,
          minHeight: screenHeight * 0.12,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: AppColors.secondaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: screenWidth * 0.08,
                color: AppColors.primaryColor,
              ),
            ),

            SizedBox(width: screenWidth * 0.04),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: AppColors.primaryColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: screenWidth * 0.045,
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative Compact Version
class CompactUserChoicePage extends StatelessWidget {
  const CompactUserChoicePage({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFF0D1B2A);
  static const Color secondaryColor = Color(0xFFD4AF37);
  static const Color backgroundColor = Color(0xFFF8F5F0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 500 : size.width,
            maxHeight: size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Compact Header
                Icon(
                  Icons.hotel,
                  size: isTablet ? 80 : 60,
                  color: primaryColor,
                ),

                const SizedBox(height: 16),

                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 28,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Choose your account type',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    color: primaryColor.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 40),

                // Compact Cards
                _buildCompactCard(
                  title: 'Client',
                  subtitle: 'Hotel services',
                  icon: Icons.person,
                  isTablet: isTablet,
                  onTap: () => Navigator.pushNamed(context, '/client-auth'),
                ),

                const SizedBox(height: 16),

                _buildCompactCard(
                  title: 'Employee',
                  subtitle: 'Staff member',
                  icon: Icons.work,
                  isTablet: isTablet,
                  onTap: () => Navigator.pushNamed(context, '/employer-auth'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isTablet,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: isTablet ? 80 : 70,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: secondaryColor.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: isTablet ? 28 : 24, color: primaryColor),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 13,
                      color: primaryColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: secondaryColor,
              size: isTablet ? 20 : 18,
            ),
          ],
        ),
      ),
    );
  }
}
