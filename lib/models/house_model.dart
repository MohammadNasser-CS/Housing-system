import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:housing_project/models/rooms_model.dart';

class HouseModel {
  final String id;
  final String imgUrl;
  final String ownerName;
  final String description;
  final String category;
  final String location;
  final int bathRoomsNumber;
  final int roomsNumber;
  final int freeRoomsNumber;
  final String phoneNumber;
  final bool isFavorite;
  final bool electricityServiceIncluded;
  final bool waterServiceIncluded;
  final bool internetServiceIncluded;
  final bool gazServiceIncluded;
  final List<BedRoomModel> bedRooms;
  final List<RoomModel> rooms;
  HouseModel({
    required this.id,
    required this.imgUrl,
    required this.ownerName,
    required this.description,
    required this.category,
    required this.location,
    required this.bathRoomsNumber,
    required this.roomsNumber,
    required this.freeRoomsNumber,
    required this.phoneNumber,
    required this.isFavorite,
    this.electricityServiceIncluded = false,
    this.waterServiceIncluded = false,
    this.internetServiceIncluded = false,
    this.gazServiceIncluded = false,
    required this.bedRooms,
    required this.rooms,
  });

  HouseModel copyWith({
    String? id,
    String? imgUrl,
    String? ownerName,
    String? description,
    String? category,
    String? location,
    int? bathRoomsNumber,
    int? roomsNumber,
    int? freeRoomsNumber,
    String? phoneNumber,
    bool? isFavorite,
    bool? electricityServiceIncluded,
    bool? waterServiceIncluded,
    bool? internetServiceIncluded,
    bool? gazServiceIncluded,
    List<BedRoomModel>? bedRooms,
    List<RoomModel>? rooms,
  }) {
    return HouseModel(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      ownerName: ownerName ?? this.ownerName,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      bathRoomsNumber: bathRoomsNumber ?? this.bathRoomsNumber,
      roomsNumber: roomsNumber ?? this.roomsNumber,
      freeRoomsNumber: freeRoomsNumber ?? this.freeRoomsNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFavorite: isFavorite ?? this.isFavorite,
      electricityServiceIncluded:
          electricityServiceIncluded ?? this.electricityServiceIncluded,
      waterServiceIncluded: waterServiceIncluded ?? this.waterServiceIncluded,
      internetServiceIncluded:
          internetServiceIncluded ?? this.internetServiceIncluded,
      gazServiceIncluded: gazServiceIncluded ?? this.gazServiceIncluded,
      bedRooms: bedRooms ?? this.bedRooms,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'ownerName': ownerName});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result.addAll({'location': location});
    result.addAll({'bathRoomsNumber': bathRoomsNumber});
    result.addAll({'roomsNumber': roomsNumber});
    result.addAll({'freeRoomsNumber': freeRoomsNumber});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'electricityServiceIncluded': electricityServiceIncluded});
    result.addAll({'waterServiceIncluded': waterServiceIncluded});
    result.addAll({'internetServiceIncluded': internetServiceIncluded});
    result.addAll({'gazServiceIncluded': gazServiceIncluded});
    result.addAll({'bedRooms': bedRooms.map((x) => x.toMap()).toList()});
    result.addAll({'rooms': rooms.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      ownerName: map['ownerName'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
      bathRoomsNumber: map['bathRoomsNumber']?.toInt() ?? 0,
      roomsNumber: map['roomsNumber']?.toInt() ?? 0,
      freeRoomsNumber: map['freeRoomsNumber']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      electricityServiceIncluded: map['electricityServiceIncluded'] ?? false,
      waterServiceIncluded: map['waterServiceIncluded'] ?? false,
      internetServiceIncluded: map['internetServiceIncluded'] ?? false,
      gazServiceIncluded: map['gazServiceIncluded'] ?? false,
      bedRooms: List<BedRoomModel>.from(
          map['bedRooms']?.map((x) => BedRoomModel.fromMap(x))),
      rooms:
          List<RoomModel>.from(map['rooms']?.map((x) => RoomModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseModel.fromJson(String source) =>
      HouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseModel(id: $id, imgUrl: $imgUrl, ownerName: $ownerName, description: $description, category: $category, location: $location, bathRoomsNumber: $bathRoomsNumber, roomsNumber: $roomsNumber, freeRoomsNumber: $freeRoomsNumber, phoneNumber: $phoneNumber, isFavorite: $isFavorite, electricityServiceIncluded: $electricityServiceIncluded, waterServiceIncluded: $waterServiceIncluded, internetServiceIncluded: $internetServiceIncluded, gazServiceIncluded: $gazServiceIncluded, bedRooms: $bedRooms, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseModel &&
        other.id == id &&
        other.imgUrl == imgUrl &&
        other.ownerName == ownerName &&
        other.description == description &&
        other.category == category &&
        other.location == location &&
        other.bathRoomsNumber == bathRoomsNumber &&
        other.roomsNumber == roomsNumber &&
        other.freeRoomsNumber == freeRoomsNumber &&
        other.phoneNumber == phoneNumber &&
        other.isFavorite == isFavorite &&
        other.electricityServiceIncluded == electricityServiceIncluded &&
        other.waterServiceIncluded == waterServiceIncluded &&
        other.internetServiceIncluded == internetServiceIncluded &&
        other.gazServiceIncluded == gazServiceIncluded &&
        listEquals(other.bedRooms, bedRooms) &&
        listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imgUrl.hashCode ^
        ownerName.hashCode ^
        description.hashCode ^
        category.hashCode ^
        location.hashCode ^
        bathRoomsNumber.hashCode ^
        roomsNumber.hashCode ^
        freeRoomsNumber.hashCode ^
        phoneNumber.hashCode ^
        isFavorite.hashCode ^
        electricityServiceIncluded.hashCode ^
        waterServiceIncluded.hashCode ^
        internetServiceIncluded.hashCode ^
        gazServiceIncluded.hashCode ^
        bedRooms.hashCode ^
        rooms.hashCode;
  }
}

List<HouseModel> dummyItems = [
  HouseModel(
    id: '1',
    imgUrl:
        'https://mostaql.hsoubcdn.com/uploads/thumbnails/532092/61924863e0137/9a8e4585198345.6030fcab71084.jpg',
    ownerName: 'مالك 1',
    description:
        'سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي سكن جامعي ',
    category: 'شقة',
    isFavorite: false,
    location: 'نابلس - شارع الجامعة',
    bathRoomsNumber: 2,
    roomsNumber: 5,
    freeRoomsNumber: 2,
    phoneNumber: '0568891980',
    rooms: dummyRooms,
    bedRooms: dummyBedRooms,
  ),
  HouseModel(
    id: '2',
    imgUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/107181991.jpg?k=1057fc1d1e2128151fe7d135902d56462793d19a2d195b7386e204b5d85e2d0c&o=&hp=1',
    ownerName: 'مالك 2',
    description: 'سكن جامعي',
    category: 'أستوديو',
    isFavorite: false,
    location: 'نابلس',
    bathRoomsNumber: 2,
    roomsNumber: 5,
    freeRoomsNumber: 2,
    phoneNumber: '0568991980',
    rooms: dummyRooms,
    bedRooms: dummyBedRooms,
  ),
];
List<HouseModel> filterdHouses = dummyItems;
