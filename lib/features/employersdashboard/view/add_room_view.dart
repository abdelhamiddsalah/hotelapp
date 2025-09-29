import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelapp/core/di/getit.dart';
import 'package:hotelapp/features/employersdashboard/view/viewmodel/cubits/cubit/add_room_cubit.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/add_room_widget.dart';

class AddRoomView extends StatelessWidget {
  const AddRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddRoomCubit>(create: (_) => sl<AddRoomCubit>(), child: AddRoomWidget());
  }
}