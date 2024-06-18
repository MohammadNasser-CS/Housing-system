import 'dart:convert';

import 'package:flutter/foundation.dart';

class HouseDetailsModel {
  final String houseId;
  final String ownerName;
  final String housePhoto;
  final bool isFavorite;
  final String description;
  final String electricity;
  final String water;
  final String internet;
  final String gas;
  final String phoneNumber;
  final List<Map<String,String>> primaryRooms;
  final List<Map<String,String>> secondaryRooms;
  HouseDetailsModel({
    required this.houseId,
    required this.ownerName,
    required this.housePhoto,
    required this.isFavorite,
    required this.description,
    required this.electricity,
    required this.water,
    required this.internet,
    required this.gas,
    required this.phoneNumber,
    required this.primaryRooms,
    required this.secondaryRooms,
  });

  HouseDetailsModel copyWith({
    String? houseId,
    String? ownerName,
    String? housePhoto,
    bool? isFavorite,
    String? description,
    String? electricity,
    String? water,
    String? internet,
    String? gas,
    String? phoneNumber,
    List<Map<String,String>>? primaryRooms,
    List<Map<String,String>>? secondaryRooms,
  }) {
    return HouseDetailsModel(
      houseId: houseId ?? this.houseId,
      ownerName: ownerName ?? this.ownerName,
      housePhoto: housePhoto ?? this.housePhoto,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      electricity: electricity ?? this.electricity,
      water: water ?? this.water,
      internet: internet ?? this.internet,
      gas: gas ?? this.gas,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      primaryRooms: primaryRooms ?? this.primaryRooms,
      secondaryRooms: secondaryRooms ?? this.secondaryRooms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'houseId': houseId});
    result.addAll({'ownerName': ownerName});
    result.addAll({'housePhoto': housePhoto});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'description': description});
    result.addAll({'electricity': electricity});
    result.addAll({'water': water});
    result.addAll({'internet': internet});
    result.addAll({'gas': gas});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'primaryRooms': primaryRooms});
    result.addAll({'secondaryRooms': secondaryRooms});
  
    return result;
  }

  factory HouseDetailsModel.fromMap(Map<String, dynamic> map) {
    return HouseDetailsModel(
      houseId: map['houseId'] ?? '',
      ownerName: map['ownerName'] ?? '',
      housePhoto: map['housePhoto'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      description: map['description'] ?? '',
      electricity: map['electricity'] ?? '',
      water: map['water'] ?? '',
      internet: map['internet'] ?? '',
      gas: map['gas'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
     primaryRooms: (map['primaryRooms'] as List<dynamic>?)
        ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
        .toList() ?? [],
    secondaryRooms: (map['secondaryRooms'] as List<dynamic>?)
        ?.map((x) => Map<String, String>.from(x as Map<String, dynamic>))
        .toList() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseDetailsModel.fromJson(String source) => HouseDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseDetailsModel(houseId: $houseId, ownerName: $ownerName, housePhoto: $housePhoto, isFavorite: $isFavorite, description: $description, electricity: $electricity, water: $water, internet: $internet, gas: $gas, phoneNumber: $phoneNumber, primaryRooms: $primaryRooms, secondaryRooms: $secondaryRooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HouseDetailsModel &&
      other.houseId == houseId &&
      other.ownerName == ownerName &&
      other.housePhoto == housePhoto &&
      other.isFavorite == isFavorite &&
      other.description == description &&
      other.electricity == electricity &&
      other.water == water &&
      other.internet == internet &&
      other.gas == gas &&
      other.phoneNumber == phoneNumber &&
      listEquals(other.primaryRooms, primaryRooms) &&
      listEquals(other.secondaryRooms, secondaryRooms);
  }

  @override
  int get hashCode {
    return houseId.hashCode ^
      ownerName.hashCode ^
      housePhoto.hashCode ^
      isFavorite.hashCode ^
      description.hashCode ^
      electricity.hashCode ^
      water.hashCode ^
      internet.hashCode ^
      gas.hashCode ^
      phoneNumber.hashCode ^
      primaryRooms.hashCode ^
      secondaryRooms.hashCode;
  }
}
