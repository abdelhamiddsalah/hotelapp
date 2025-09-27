import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';

// Room Types Enum
enum RoomTypes { SINGLE, DOUBLE, SUITE, DELUXE }

class AddRoomWidget extends StatefulWidget {
  const AddRoomWidget({super.key});

  @override
  _AddRoomWidgetState createState() => _AddRoomWidgetState();
}

class _AddRoomWidgetState extends State<AddRoomWidget> {
  final _formKey = GlobalKey<FormState>();
  final _roomNumberController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  RoomTypes? selectedRoomType;
  bool isReserved = false;
  
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
    'Refrigerator'
  ];
  
  Set<String> selectedAmenities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Add New Room',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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
                child: Column(
                  children: [
                    Icon(
                      Icons.hotel,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Room Registration Form',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Fill in the details to add a new room to the hotel',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // Basic Information Section
              _buildSectionHeader('Basic Information', Icons.info_outline),
              SizedBox(height: 15),
              
              _buildCard([
                // Room Number
                _buildTextFormField(
                  controller: _roomNumberController,
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
                  controller: _priceController,
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
                  controller: _descriptionController,
                  label: 'Room Description',
                  hint: 'Enter detailed description of the room',
                  icon: Icons.description,
                  maxLines: 4,
                ),
                
                SizedBox(height: 20),
                
                // Image URL
                _buildTextFormField(
                  controller: _imageController,
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
                    child: _buildButton(
                      text: 'Cancel',
                      color: Colors.grey[600]!,
                      onPressed: () => Navigator.pop(context),
                      isSecondary: true,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: _buildButton(
                      text: 'Add Room',
                      color: AppColors.primaryColor,
                      onPressed: () {
                        // Form validation and submission logic would go here
                        _showSuccessDialog();
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
          value: selectedRoomType,
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
            return DropdownMenuItem(
              value: type,
              child: Text(_getRoomTypeText(type)),
            );
          }).toList(),
          onChanged: (value) => setState(() => selectedRoomType = value),
        ),
      ],
    );
  }

  Widget _buildReservationToggle() {
    return Row(
      children: [
        Icon(Icons.toggle_on, color: AppColors.primaryColor),
        SizedBox(width: 10),
        Text(
          'Room Status',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        Spacer(),
        Switch(
          value: isReserved,
          onChanged: (value) => setState(() => isReserved = value),
          activeColor: AppColors.secondaryColor,
          activeTrackColor: AppColors.secondaryColor.withOpacity(0.3),
        ),
        Text(
          isReserved ? 'Reserved' : 'Available',
          style: TextStyle(
            color: isReserved ? Colors.orange : Colors.green,
            fontWeight: FontWeight.w500,
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
              color: isSelected ? AppColors.secondaryColor.withOpacity(0.2) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? AppColors.secondaryColor : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? AppColors.secondaryColor : Colors.grey[500],
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppColors.primaryColor : Colors.grey[700],
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

  Widget _buildButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.transparent : color,
        foregroundColor: isSecondary ? color : Colors.white,
        side: isSecondary ? BorderSide(color: color) : null,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: isSecondary ? 0 : 3,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getRoomTypeText(RoomTypes type) {
    switch (type) {
      case RoomTypes.SINGLE:
        return 'Single Room';
      case RoomTypes.DOUBLE:
        return 'Double Room';
      case RoomTypes.SUITE:
        return 'Suite';
      case RoomTypes.DELUXE:
        return 'Deluxe Room';
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Success!'),
            ],
          ),
          content: Text('Room has been added successfully to the hotel.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _roomNumberController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}