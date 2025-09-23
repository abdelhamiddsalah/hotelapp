import 'dart:io';

class Endpoints {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080/api/"; // Emulator
    } else {
      return "http://localhost:8080/api/"; // Windows / macOS
    }
  }

  static const String signupTeacher = "teacher/createTeacher";
  static const String loginTeacher = "teacher/loginTeacher";
  static const String forgetPassword = "teacher/forgetpassword";

}
