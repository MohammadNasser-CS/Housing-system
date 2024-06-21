import 'dart:convert';

import 'package:flutter/foundation.dart';

class OwnerHouseDetailsModel {
  final String houseId;
  final String description;
  final String internet;
  final String water;
  final String electricity;
  final String gas;
  final String housePhoto;
  final List<Map<String, String>> primaryRooms;
  final List<Map<String, String>> secondaryRooms;
  final List<Map<String, String>>? reservationData;
  OwnerHouseDetailsModel({
    required this.houseId,
    required this.description,
    required this.internet,
    required this.water,
    required this.electricity,
    required this.gas,
    required this.housePhoto,
    required this.primaryRooms,
    required this.secondaryRooms,
    this.reservationData,
  });

  OwnerHouseDetailsModel copyWith({
    String? houseId,
    String? description,
    String? internet,
    String? water,
    String? electricity,
    String? gas,
    String? housePhoto,
    List<Map<String, String>>? primaryRooms,
    List<Map<String, String>>? secondaryRooms,
    List<Map<String, String>>? reservationData,
  }) {
    return OwnerHouseDetailsModel(
      houseId: houseId ?? this.houseId,
      description: description ?? this.description,
      internet: internet ?? this.internet,
      water: water ?? this.water,
      electricity: electricity ?? this.electricity,
      gas: gas ?? this.gas,
      housePhoto: housePhoto ?? this.housePhoto,
      primaryRooms: primaryRooms ?? this.primaryRooms,
      secondaryRooms: secondaryRooms ?? this.secondaryRooms,
      reservationData: reservationData ?? this.reservationData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'houseId': houseId});
    result.addAll({'description': description});
    result.addAll({'internet': internet});
    result.addAll({'water': water});
    result.addAll({'electricity': electricity});
    result.addAll({'gas': gas});
    result.addAll({'housePhoto': housePhoto});
    result.addAll({'primaryRooms': primaryRooms});
    result.addAll({'secondaryRooms': secondaryRooms});
    if (reservationData != null) {
      result.addAll({'reservationData': reservationData});
    }

    return result;
  }

  factory OwnerHouseDetailsModel.fromMap(Map<String, dynamic> map) {
    return OwnerHouseDetailsModel(
      houseId: map['houseId'] ?? '',
      description: map['description'] ?? '',
      internet: map['internet'] ?? '',
      water: map['water'] ?? '',
      electricity: map['electricity'] ?? '',
      gas: map['gas'] ?? '',
      housePhoto: map['housePhoto'] ?? '',
      primaryRooms: (map['primaryRooms'] as List<dynamic>?)
              ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
              .toList() ??
          [],
      secondaryRooms: (map['secondaryRooms'] as List<dynamic>?)
              ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
              .toList() ??
          [],
      reservationData: (map['reservationData'] as List<dynamic>?)
              ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerHouseDetailsModel.fromJson(String source) =>
      OwnerHouseDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnerHouseDetailsModel(houseId: $houseId, description: $description, internet: $internet, water: $water, electricity: $electricity, gas: $gas, housePhoto: $housePhoto, primaryRooms: $primaryRooms, secondaryRooms: $secondaryRooms, reservationData: $reservationData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerHouseDetailsModel &&
        other.houseId == houseId &&
        other.description == description &&
        other.internet == internet &&
        other.water == water &&
        other.electricity == electricity &&
        other.gas == gas &&
        other.housePhoto == housePhoto &&
        listEquals(other.primaryRooms, primaryRooms) &&
        listEquals(other.secondaryRooms, secondaryRooms) &&
        listEquals(other.reservationData, reservationData);
  }

  @override
  int get hashCode {
    return houseId.hashCode ^
        description.hashCode ^
        internet.hashCode ^
        water.hashCode ^
        electricity.hashCode ^
        gas.hashCode ^
        housePhoto.hashCode ^
        primaryRooms.hashCode ^
        secondaryRooms.hashCode ^
        reservationData.hashCode;
  }
}
