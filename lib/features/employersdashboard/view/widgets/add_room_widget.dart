import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/widgets/custom_button.dart';
import 'package:hotelapp/core/widgets/main_app_bar.dart';
import 'package:hotelapp/features/clientsdashboard/data/models/room_model.dart';
import 'package:hotelapp/features/employersdashboard/view/viewmodel/cubits/cubit/add_room_cubit.dart';
import 'package:hotelapp/core/enums/enum.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/header_in_add_room.dart'; // Import the shared RoomTypes enum

class AddRoomWidget extends StatefulWidget {
  const AddRoomWidget({super.key});

  @override
  _AddRoomWidgetState createState() => _AddRoomWidgetState();
}

class _AddRoomWidgetState extends State<AddRoomWidget> {
  // Available amenities
  List<String> availableAmenities = [
    'WiFi',
    'Air Conditioning',
    'Television',
    'Mini Bar',
    'Balcony',
    'Ocean View',
    'Room Service',
    'Jacuzzi',
    'Safe',
    'Desk',
    'Coffee Maker',
    'Refrigerator',
  ];

  Set<String> selectedAmenities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MainAppBar(title: 'Add New Room'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: context.read<AddRoomCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: HeaderInAddRoom(),
              ),

              SizedBox(height: 25),

              // Basic Information Section
              _buildSectionHeader('Basic Information', Icons.info_outline),
              SizedBox(height: 15),

              _buildCard([
                // Room Number
                _buildTextFormField(
                  controller: context.read<AddRoomCubit>().roomNumberController,
                  label: 'Room Number',
                  hint: 'Enter room number (e.g., 101, 205)',
                  icon: Icons.numbers,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 20),

                // Room Type Dropdown
                _buildDropdownField(),

                SizedBox(height: 20),

                // Price Field
                _buildTextFormField(
                  controller: context.read<AddRoomCubit>().priceController,
                  label: 'Price per Night (\$)',
                  hint: 'Enter price per night',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ]),

              SizedBox(height: 25),

              // Room Details Section
              _buildSectionHeader('Room Details', Icons.description),
              SizedBox(height: 15),

              _buildCard([
                // Description
                _buildTextFormField(
                  controller: context
                      .read<AddRoomCubit>()
                      .descriptionController,
                  label: 'Room Description',
                  hint: 'Enter detailed description of the room',
                  icon: Icons.description,
                  maxLines: 4,
                ),

                SizedBox(height: 20),

                // Image URL
                _buildTextFormField(
                  controller: context.read<AddRoomCubit>().imageController,
                  label: 'Room Image URL',
                  hint: 'Enter image URL for the room',
                  icon: Icons.image,
                ),

                SizedBox(height: 20),

                // Reservation Status
                _buildReservationToggle(),
              ]),

              SizedBox(height: 25),

              // Amenities Section
              _buildSectionHeader('Room Amenities', Icons.star),
              SizedBox(height: 15),

              _buildCard([
                Text(
                  'Select available amenities for this room:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 15),
                _buildAmenitiesGrid(),
              ]),

              SizedBox(height: 30),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      color: Colors.grey[600]!,
                      onPressed: () => context.pop(),
                      isSecondary: true,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: BlocConsumer<AddRoomCubit, AddRoomState>(
                      listener: (context, state) {
                        if (state is RoomNumberIsFound) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Room number already exists!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (state is AddRoomSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Room added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state is AddRoomError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to add room. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text:  state is AddRoomLoading ? 'Adding Room...' : 'Add Room',
                        onPressed: () {
  // اربط الـ amenities من الـ UI للـ Cubit
  context.read<AddRoomCubit>().amenities
    ..clear()
    ..addAll(selectedAmenities);

  context.read<AddRoomCubit>().addRoom(
    RoomModel(
      roomNumber: int.parse(
        context.read<AddRoomCubit>().roomNumberController.text,
      ),
      isReversed: context.read<AddRoomCubit>().isReserved,
      image: context.read<AddRoomCubit>().imageController.text,
      price: double.parse(
        context.read<AddRoomCubit>().priceController.text,
      ),
      type: context.read<AddRoomCubit>().selectedRoomType?.name ?? 'SINGLE',
      description: context.read<AddRoomCubit>().descriptionController.text,
      amenities: List<String>.from(selectedAmenities), // Use selectedAmenities directly
    ),
  );
},

                          color: AppColors.primaryColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildReservationToggle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Reservation Status:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          ChoiceChip(
            label: Text('Available'),
            selected: !context.read<AddRoomCubit>().isReserved,
            onSelected: (selected) {
              setState(() {
                context.read<AddRoomCubit>().isReserved = false;
              });
            },
            selectedColor: AppColors.secondaryColor.withOpacity(0.2),
          ),
          SizedBox(width: 10),
          ChoiceChip(
            label: Text('Reserved'),
            selected: context.read<AddRoomCubit>().isReserved,
            onSelected: (selected) {
              setState(() {
                context.read<AddRoomCubit>().isReserved = true;
              });
            },
            selectedColor: AppColors.secondaryColor.withOpacity(0.2),
          ),
        ],
      ),
    ],
  );
}


  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 24),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(left: 15),
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
            ),
            filled: true,
            fillColor: AppColors.backgroundColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Room Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<RoomTypes>(
          value: context.read<AddRoomCubit>().selectedRoomType,
          decoration: InputDecoration(
            hintText: 'Select room type',
            prefixIcon: Icon(Icons.bed, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
            ),
            filled: true,
            fillColor: AppColors.backgroundColor,
          ),
          items: RoomTypes.values.map((type) {
            return DropdownMenuItem(value: type, child: Text(type.name));
          }).toList(),
          onChanged: (value) => setState(
            () => context.read<AddRoomCubit>().selectedRoomType = value,
          ),
        ),
      ],
    );
  }

 

  Widget _buildAmenitiesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: availableAmenities.length,
      itemBuilder: (context, index) {
        final amenity = availableAmenities[index];
        final isSelected = selectedAmenities.contains(amenity);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedAmenities.remove(amenity);
              } else {
                selectedAmenities.add(amenity);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.secondaryColor.withOpacity(0.2)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppColors.secondaryColor
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? AppColors.secondaryColor
                        : Colors.grey[500],
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
