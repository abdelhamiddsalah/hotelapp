import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotelapp/core/enums/enum.dart';
import 'package:hotelapp/features/clientsdashboard/data/models/room_model.dart';
import 'package:hotelapp/features/employersdashboard/data/repos/employers_repo.dart';
import 'package:meta/meta.dart';

part 'add_room_state.dart';

class AddRoomCubit extends Cubit<AddRoomState> {
  final EmployersRepo employersRepo;
  AddRoomCubit( {required this.employersRepo}) : super(AddRoomInitial());

  final formKey = GlobalKey<FormState>();
  final roomNumberController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();
  final List<String> amenities = [];

  RoomTypes? selectedRoomType;
  bool isReserved = false;

 void addRoom(RoomModel roomData) async {
  emit(AddRoomLoading());

  final existsEither = await employersRepo.roomNumberExists(roomData.roomNumber.toString());

  existsEither.fold(
    (error) {
      emit(AddRoomError());
    },
    (exists) async {
      if (exists) {
        emit(RoomNumberIsFound());
        return;
      }

      final addEither = await employersRepo.addRoom(roomData);
      addEither.fold(
        (l) => emit(AddRoomError()),
        (r) => emit(AddRoomSuccess()),
      );
    },
  );
}


  void dispose() {
    roomNumberController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
  }
}
