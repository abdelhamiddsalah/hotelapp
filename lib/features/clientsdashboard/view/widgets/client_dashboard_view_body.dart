import 'package:flutter/material.dart';
import 'package:hotelapp/core/enums/enum.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/widgets/messaes.dart';
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
              itemCount: 4,
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
                           RoomTypes.values[index].name,
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
                  '${RoomTypes.values[selectedRoomType].name} Rooms',
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
                itemCount:6,
                itemBuilder: (context, index) {
                  final roomModel = RoomModel.fromJson(rooms[index]).copyWith(type: RoomTypes.values[selectedRoomType].name);
                  return RoomCard(context: context, room: roomModel, index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
