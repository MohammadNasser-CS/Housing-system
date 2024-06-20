import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:housing_project/models/houses_models/room_details_models/time_slots_model.dart';

class RoomModel {
  final String roomId;
  final String roomSpace;
  final String balcony;
  final String desk;
  final String avalabileBed;
  final String price;
  final String ac;
  final List<String> roomPhotos;
  final List<TimeRequests> availableTimes;
  RoomModel({
    required this.roomId,
    required this.roomSpace,
    required this.balcony,
    required this.desk,
    required this.avalabileBed,
    required this.price,
    required this.ac,
    required this.roomPhotos,
    required this.availableTimes,
  });

  RoomModel copyWith({
    String? roomId,
    String? roomSpace,
    String? balcony,
    String? desk,
    String? avalabileBed,
    String? price,
    String? ac,
    List<String>? roomPhotos,
    List<TimeRequests>? availableTimes,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      roomSpace: roomSpace ?? this.roomSpace,
      balcony: balcony ?? this.balcony,
      desk: desk ?? this.desk,
      avalabileBed: avalabileBed ?? this.avalabileBed,
      price: price ?? this.price,
      ac: ac ?? this.ac,
      roomPhotos: roomPhotos ?? this.roomPhotos,
      availableTimes: availableTimes ?? this.availableTimes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'roomId': roomId});
    result.addAll({'roomSpace': roomSpace});
    result.addAll({'balcony': balcony});
    result.addAll({'desk': desk});
    result.addAll({'avalabileBed': avalabileBed});
    result.addAll({'price': price});
    result.addAll({'ac': ac});
    result.addAll({'roomPhotos': roomPhotos});
    result.addAll({'availableTimes': availableTimes});

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? '',
      roomSpace: map['roomSpace'] ?? '',
      balcony: map['balcony'] ?? '',
      desk: map['desk'] ?? '',
      avalabileBed: map['avalabileBed']?.toString() ?? '',
      price: map['price']?.toString() ?? '',
      ac: map['ac'] ?? '',
      roomPhotos: (map['roomPhotos'] as List<dynamic>)
          .map((photo) => photo.toString())
          .toList(),
      availableTimes: (map['availableTimes'] != null &&
              map['availableTimes'] is List<dynamic>)
          ? (map['availableTimes'] as List<dynamic>)
              .map((timeSlot) => TimeRequests.fromMap(timeSlot))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(roomId: $roomId, roomSpace: $roomSpace, balcony: $balcony, desk: $desk, avalabileBed: $avalabileBed, price: $price, ac: $ac, roomPhotos: $roomPhotos, availableTimes: $availableTimes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.roomId == roomId &&
        other.roomSpace == roomSpace &&
        other.balcony == balcony &&
        other.desk == desk &&
        other.avalabileBed == avalabileBed &&
        other.price == price &&
        other.ac == ac &&
        listEquals(other.roomPhotos, roomPhotos) &&
        listEquals(other.availableTimes, availableTimes);
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        roomSpace.hashCode ^
        balcony.hashCode ^
        desk.hashCode ^
        avalabileBed.hashCode ^
        price.hashCode ^
        ac.hashCode ^
        roomPhotos.hashCode ^
        availableTimes.hashCode;
  }
}
