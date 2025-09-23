import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'dart:async';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        print("🚫 لا يوجد اتصال بالشبكة (WiFi أو بيانات)");
        return false;
      }

      // محاولة التحقق من الإنترنت الحقيقي عبر google.com بمهلة قصيرة
      try {
        final result = await InternetAddress.lookup('google.com')
            .timeout(const Duration(seconds: 3));

        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print("✅ الإنترنت متصل فعليًا");
          return true;
        } else {
          print("⚠️ لا يوجد استجابة من google.com رغم وجود شبكة");
          return false;
        }
      } catch (e) {
        print("⚠️ فشل التحقق من الإنترنت (google.com): $e");
        // احتمال نرجع true أو false هنا حسب ما تحب:
        // return true; // لتجاوز المشكلة مؤقتًا
        return false;
      }
    } catch (e) {
      print("❌ خطأ في التحقق من الاتصال: $e");
      return false;
    }
  }
}
