import 'package:flutter/material.dart';
import 'package:hotelapp/core/di/getit.dart';
import 'package:hotelapp/core/routing/app_routing.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HOTEL',
      routerConfig: AppRouting.router,
    );
  }
}
