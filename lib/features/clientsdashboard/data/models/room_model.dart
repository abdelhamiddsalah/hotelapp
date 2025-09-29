class RoomModel {
  final int roomNumber;
  final bool isReversed;
  final String image;
  final double price;
  final String type;
  final String description;
  final List<String> amenities;

  RoomModel({
    required this.roomNumber,
    required this.isReversed,
    required this.image,
    required this.price,
    required this.type,
    required this.description,
    required this.amenities,
  });

  /// Factory لتحويل JSON → Object
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomNumber: json['roomNumber'],
      isReversed: json['isReversed'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      type: json['type'],
      description: json['description'],
      amenities: List<String>.from(json['amenities']),
    );
  }

  /// لتحويل Object → JSON
  Map<String, dynamic> toJson() {
    return {
      'roomNumber': roomNumber,
      'isReversed': isReversed,
      'image': image,
      'price': price,
      'type': type,
      'description': description,
      'amenities': amenities,
    };
  }

  copyWith({
    int? roomNumber,
    bool? isReversed,
    String? image,
    double? price,
    String? type,
    String? description,
    List<String>? amenities,
  }) {
    return RoomModel(
      roomNumber: roomNumber ?? this.roomNumber,
      isReversed: isReversed ?? this.isReversed,
      image: image ?? this.image,
      price: price ?? this.price,
      type: type ?? this.type,
      description: description ?? this.description,
      amenities: amenities ?? this.amenities,
    );
  }
}
