import 'dart:io';

class Endpoints {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080/api/"; // Emulator
    } else {
      return "http://localhost:8080/api/"; // Windows / macOS
    }
  }

  static const String addRoom = "rooms/addRoom";
  static const String getAllRooms = "rooms/getRooms";
  static String getAllRoomsByType(String type) => "rooms/getRoomsByType/$type";
  static String getRoomById(int id) => "rooms/getRoomByid/$id";
}
