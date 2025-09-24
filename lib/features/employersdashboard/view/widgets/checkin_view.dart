import 'package:flutter/material.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/card_in_checkin.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/sliver_app_bar.dart';

class CheckInOutView extends StatefulWidget {
  const CheckInOutView({super.key});

  @override
  State<CheckInOutView> createState() => _CheckInOutViewState();
}

class _CheckInOutViewState extends State<CheckInOutView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppbarr(
            animationController: _animationController,
            title: 'Check-in / Check-out',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
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
                    child: CheckInCard(index: index),
                  ),
                ),
                childCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
