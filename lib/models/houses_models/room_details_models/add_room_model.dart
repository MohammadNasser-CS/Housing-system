import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddRoomModel {
  final String houseId;
  final String roomType;
  final String bedNumber;
  final String bedNumberBooked;
  final String roomSpace;
  final String balcony;
  final String desk;
  final String ac;
  final String price;
  final List<Map<String,String>> photos;
  AddRoomModel({
    required this.houseId,
    required this.roomType,
    required this.bedNumber,
    required this.bedNumberBooked,
    required this.roomSpace,
    required this.balcony,
    required this.desk,
    required this.ac,
    required this.price,
    required this.photos,
  });

  AddRoomModel copyWith({
    String? houseId,
    String? roomType,
    String? bedNumber,
    String? bedNumberBooked,
    String? roomSpace,
    String? balcony,
    String? desk,
    String? ac,
    String? price,
    List<Map<String,String>>? photos,
  }) {
    return AddRoomModel(
      houseId: houseId ?? this.houseId,
      roomType: roomType ?? this.roomType,
      bedNumber: bedNumber ?? this.bedNumber,
      bedNumberBooked: bedNumberBooked ?? this.bedNumberBooked,
      roomSpace: roomSpace ?? this.roomSpace,
      balcony: balcony ?? this.balcony,
      desk: desk ?? this.desk,
      ac: ac ?? this.ac,
      price: price ?? this.price,
      photos: photos ?? this.photos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'houseId': houseId});
    result.addAll({'roomType': roomType});
    result.addAll({'bedNumber': bedNumber});
    result.addAll({'bedNumberBooked': bedNumberBooked});
    result.addAll({'roomSpace': roomSpace});
    result.addAll({'balcony': balcony});
    result.addAll({'desk': desk});
    result.addAll({'ac': ac});
    result.addAll({'price': price});
    result.addAll({'photos': photos});
  
    return result;
  }

  factory AddRoomModel.fromMap(Map<String, dynamic> map) {
    return AddRoomModel(
      houseId: map['houseId'] ?? '',
      roomType: map['roomType'] ?? '',
      bedNumber: map['bedNumber'] ?? '',
      bedNumberBooked: map['bedNumberBooked'] ?? '',
      roomSpace: map['roomSpace'] ?? '',
      balcony: map['balcony'] ?? '',
      desk: map['desk'] ?? '',
      ac: map['ac'] ?? '',
      price: map['price'] ?? '',
       photos: (map['photos'] as List<dynamic>?)
        ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
        .toList() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddRoomModel.fromJson(String source) => AddRoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddRoomModel(houseId: $houseId, roomType: $roomType, bedNumber: $bedNumber, bedNumberBooked: $bedNumberBooked, roomSpace: $roomSpace, balcony: $balcony, desk: $desk, ac: $ac, price: $price, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddRoomModel &&
      other.houseId == houseId &&
      other.roomType == roomType &&
      other.bedNumber == bedNumber &&
      other.bedNumberBooked == bedNumberBooked &&
      other.roomSpace == roomSpace &&
      other.balcony == balcony &&
      other.desk == desk &&
      other.ac == ac &&
      other.price == price &&
      listEquals(other.photos, photos);
  }

  @override
  int get hashCode {
    return houseId.hashCode ^
      roomType.hashCode ^
      bedNumber.hashCode ^
      bedNumberBooked.hashCode ^
      roomSpace.hashCode ^
      balcony.hashCode ^
      desk.hashCode ^
      ac.hashCode ^
      price.hashCode ^
      photos.hashCode;
  }
}
