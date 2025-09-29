import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hotelapp/core/databases/api/dio_consumer.dart';
import 'package:hotelapp/core/databases/api/endpoints.dart';
import 'package:hotelapp/features/clientsdashboard/data/models/room_model.dart';

class EmployersRepo {
  final DioConsumer dioConsumer;
  EmployersRepo({required this.dioConsumer});

  // لو بتحب ترجع نتيجة مع إمكانيه معرفة الخطأ، ارجع Either
 Future<Either<String, Response>> addRoom(RoomModel roomData) async {
  final result = await dioConsumer.post(
    path: Endpoints.addRoom,
    data: roomData.toJson(),
  );

  // اطبع الرد للديباج
  return result.fold(
    (error) {
      print("❌ Add Room Failed: $error");
      return Left(error);
    },
    (response) {
      print("✅ Add Room Success: ${response.data}");
      return Right(response);
    },
  );
}

Future<Either<String, bool>> roomNumberExists(String roomNumber) async {
  final either = await dioConsumer.get(
    path: Endpoints.getRoomById(int.parse(roomNumber)),
  );

  return either.fold(
    (leftError) => Left(leftError),
    (response) {
      // لو السيرفر قال 404 => مش موجود
      if (response.statusCode == 404) return Right(false);

      // لو 200 ومعاه بيانات => موجود
      if (response.statusCode == 200) return Right(true);

      // fallback: غير متوقع
      return Left('Unexpected response: ${response.statusCode}');
    },
  );
}

}
