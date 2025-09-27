import 'package:flutter/material.dart';
import 'package:hotelapp/core/enums/enum.dart';
import 'package:hotelapp/core/styling/colors.dart';

class BodyDetailsInRoom extends StatelessWidget {
  const BodyDetailsInRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price Section
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                AppColors.backgroundColor.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withOpacity(
                    0.2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.attach_money,
                  color: AppColors.secondaryColor,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price per night',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${123.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  'Best Price',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
    
        SizedBox(height: 24),
        ////////////////////////////////////////////////
        // Description Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                'Experience luxury and comfort in this beautiful room with modern amenities and elegant design.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
    
        SizedBox(height: 24),
        /////////////////////////////////////////////////
        // Amenities Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: AppColors.primaryColor),
                SizedBox(width: 8),
                Text(
                  'Amenities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              /*  child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.room.amenities.map((amenity) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
    color: AppColors.primaryColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                    ),
                    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        _getAmenityIcon(amenity),
        color: AppColors.primaryColor,
        size: 16,
      ),
      SizedBox(width: 6),
      Text(
        amenity,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ],
                    ),
                  );
                }).toList(),
              ),*/
            ),
          ],
        ),
    
        SizedBox(height: 24),
        //////////////////////////////////////////////////
        // Room Features
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Room Features',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.king_bed,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Room Type:',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            RoomTypes.SINGLE == RoomTypes.SINGLE
                                ? 'Single Room'
                                : 'Double Room',
                            style: TextStyle(
                              color:
                                  (null) ??
                                  AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.numbers,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Room Number:',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            123.toString(),
                            style: TextStyle(
                              color:
                                  (null) ??
                                  AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          true ? Icons.lock : Icons.lock_open,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Status:',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            true ? 'Reserved' : 'Available',
                            style: TextStyle(
                              color:
                                  (true
                                      ? Colors.red
                                      : Colors.green) ??
                                  AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    
        SizedBox(height: 32),
        //////////////////////////////////////////////////////////
        // Book Now Button
        Container(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            // Replace 'true' with a variable like 'isReserved' to control button state
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: true
                  ? Colors.grey
                  : AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              shadowColor: AppColors.primaryColor.withOpacity(
                0.3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  true ? Icons.lock : Icons.calendar_today,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  true ? 'Room Reserved' : 'Book This Room',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
