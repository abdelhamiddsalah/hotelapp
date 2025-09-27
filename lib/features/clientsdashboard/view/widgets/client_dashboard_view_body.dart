import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/features/clientsdashboard/data/models/room_model.dart';
import 'package:hotelapp/features/clientsdashboard/view/widgets/client_app_bar.dart';
import 'package:hotelapp/features/clientsdashboard/view/widgets/header_in_client_dashh.dart';
import 'package:hotelapp/features/clientsdashboard/view/widgets/room_card.dart';

class ClientDashboardViewBody extends StatefulWidget {
  const ClientDashboardViewBody({super.key});

  @override
  _ClientDashboardViewBodyState createState() =>
      _ClientDashboardViewBodyState();
}

class _ClientDashboardViewBodyState extends State<ClientDashboardViewBody> {

  int selectedRoomType = 0;

  // Room data for each category
  final Map<int, List<RoomModel>> roomData = {
    0: [
      // Single Rooms
      RoomModel(
        id: 'S001',
        name: 'Classic Single Room',
        description:
            'Comfortable room with single bed, small desk, and private bathroom',
        price: 150,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_1.webp',
      ),
      RoomModel(
        id: 'S002',
        name: 'Deluxe Single Room',
        description: 'Spacious room with city view and modern furniture',
        price: 200,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_2.webp',
      ),
    ],
    1: [
      // Double Rooms
      RoomModel(
        id: 'D001',
        name: 'Classic Double Room',
        description:
            'Room with comfortable double bed, smart TV, and room service',
        price: 250,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_1.webp',
      ),
      RoomModel(
        id: 'D002',
        name: 'Ocean View Double Room',
        description: 'Luxury room with stunning ocean view and private balcony',
        price: 350,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_2.webp',
      ),
    ],
    2: [
      // Family Rooms
      RoomModel(
        id: 'F001',
        name: 'Small Family Suite',
        description:
            'Spacious room with two double beds and separate sitting area',
        price: 400,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_1.webp',
      ),
      RoomModel(
        id: 'F002',
        name: 'Large Family Suite',
        description: 'Three bedrooms, spacious living room, and kitchenette',
        price: 600,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_2.webp',
      ),
    ],
    3: [
      // Deluxe Rooms
      RoomModel(
        id: 'DL001',
        name: 'Royal Deluxe Suite',
        description:
            'Luxurious suite with royal design, jacuzzi, and personal service',
        price: 800,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_1.webp',
      ),
      RoomModel(
        id: 'DL002',
        name: 'Presidential Suite',
        description:
            'Most luxurious suite with multiple rooms and panoramic view',
        price: 1200,
        image:
            'assets/images/assets_task_01k3e47jcbfyw93788kb3yx1m1_1756042218_img_2.webp',
      ),
    ],
  };

  final List<String> roomTypeNames = ['Single', 'Double', 'Family', 'Deluxe'];

  final List<IconData> roomTypeIcons = [
    Icons.single_bed,
    Icons.king_bed,
    Icons.family_restroom,
    Icons.apartment,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: ClientAppBar(),
      body: Column(
        children: [
          // Header Section
          HeaderInClientDasboard(),
          SizedBox(height: 20),
          // Room Type Tabs
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: roomTypeNames.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedRoomType == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRoomType = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          roomTypeIcons[index],
                          color: isSelected ? AppColors.secondaryColor : Colors.grey[600],
                          size: 24,
                        ),
                        SizedBox(height: 4),
                        Text(
                          roomTypeNames[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Selected Room Type Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  roomTypeIcons[selectedRoomType],
                  color: AppColors.primaryColor,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  '${roomTypeNames[selectedRoomType]} Rooms',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Room List
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: roomData[selectedRoomType]?.length ?? 0,
                itemBuilder: (context, index) {
                  final room = roomData[selectedRoomType]![index];
                  return RoomCard(context: context, room: room, index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
