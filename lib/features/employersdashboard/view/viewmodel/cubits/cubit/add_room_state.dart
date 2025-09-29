part of 'add_room_cubit.dart';

@immutable
sealed class AddRoomState {}

final class AddRoomInitial extends AddRoomState {}

final class AddRoomLoading extends AddRoomState {}

final class AddRoomSuccess extends AddRoomState {}

final class AddRoomError extends AddRoomState {}

final class RoomNumberIsFound extends AddRoomState{}