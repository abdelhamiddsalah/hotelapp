import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hotelapp/core/connections/network_info.dart';
import 'package:hotelapp/core/databases/api/dio_consumer.dart';
import 'package:hotelapp/core/databases/api/interceptors.dart';
import 'package:hotelapp/core/databases/cache/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  CacheHelper.sharedPreferences = sharedPreferences;

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper()); // ⬅️ السطر المهم

  sl.registerLazySingleton<LoggerInterceptor>(() => LoggerInterceptor());

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.interceptors.add(sl<LoggerInterceptor>());
    return DioConsumer(dio: dio);
  });

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

}
