
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/enums/enum.dart';
import 'package:hotelapp/core/styling/colors.dart';

class HeaderInRoomDetails extends StatelessWidget {
  const HeaderInRoomDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {
            // Add to favorites logic
          },
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {
            // Share logic
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
             Image.asset(
                  'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_1.webp',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
    colors: [AppColors.primaryColor.withOpacity(0.8), AppColors.secondaryColor.withOpacity(0.6)],
            ),
          ),
          child: Center(
            child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.hotel,
        size: 80,
        color: Colors.white,
      ),
      SizedBox(height: 16),
      Text(
        'Room ${123}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
            ),
          ),
        );
                    },
                  ),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            // Room Status Badge
            Positioned(
              top: 100,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: true 
                      ? Colors.red.withOpacity(0.9)
                      : Colors.green.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  true ? 'Reserved' : 'Available',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            
            // Room Info Overlay
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room ${123}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    RoomTypes.SINGLE == RoomTypes.SINGLE ? 'Single Room' : 'Double Room',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
