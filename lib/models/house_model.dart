

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:housing_project/models/rooms_model.dart';

class HouseModel {
  final String id;
  final String address;
  final String description;
  final String houseGender;
  final String category;
  final String location;
  final String imgUrl;
  final String ownerName;
  final String phoneNumber;
  final int? bathRoomsNumber;
  final int? roomsNumber;
  final int? freeRoomsNumber;
  final bool isFavorite;
  final bool electricityServiceIncluded;
  final bool waterServiceIncluded;
  final bool internetServiceIncluded;
  final bool gazServiceIncluded;
  final List<BedRoomModel>? bedRooms;
  final List<RoomModel>? rooms;
  HouseModel({
    required this.id,
    required this.address,
    required this.description,
    required this.houseGender,
    required this.category,
    required this.location,
    required this.imgUrl,
    required this.ownerName,
    required this.phoneNumber,
    this.bathRoomsNumber,
    this.roomsNumber,
    this.freeRoomsNumber,
    this.isFavorite=false,
     this.electricityServiceIncluded = false,
    this.waterServiceIncluded = false,
    this.internetServiceIncluded = false,
    this.gazServiceIncluded = false,
    this.bedRooms,
    this.rooms,
  });
  


  HouseModel copyWith({
    String? id,
    String? address,
    String? description,
    String? houseGender,
    String? category,
    String? location,
    String? imgUrl,
    String? ownerName,
    String? phoneNumber,
    int? bathRoomsNumber,
    int? roomsNumber,
    int? freeRoomsNumber,
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
      address: address ?? this.address,
      description: description ?? this.description,
      houseGender: houseGender ?? this.houseGender,
      category: category ?? this.category,
      location: location ?? this.location,
      imgUrl: imgUrl ?? this.imgUrl,
      ownerName: ownerName ?? this.ownerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bathRoomsNumber: bathRoomsNumber ?? this.bathRoomsNumber,
      roomsNumber: roomsNumber ?? this.roomsNumber,
      freeRoomsNumber: freeRoomsNumber ?? this.freeRoomsNumber,
      isFavorite: isFavorite ?? this.isFavorite,
      electricityServiceIncluded: electricityServiceIncluded ?? this.electricityServiceIncluded,
      waterServiceIncluded: waterServiceIncluded ?? this.waterServiceIncluded,
      internetServiceIncluded: internetServiceIncluded ?? this.internetServiceIncluded,
      gazServiceIncluded: gazServiceIncluded ?? this.gazServiceIncluded,
      bedRooms: bedRooms ?? this.bedRooms,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'address': address});
    result.addAll({'description': description});
    result.addAll({'houseGender': houseGender});
    result.addAll({'category': category});
    result.addAll({'location': location});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'ownerName': ownerName});
    result.addAll({'phoneNumber': phoneNumber});
    if(bathRoomsNumber != null){
      result.addAll({'bathRoomsNumber': bathRoomsNumber});
    }
    if(roomsNumber != null){
      result.addAll({'roomsNumber': roomsNumber});
    }
    if(freeRoomsNumber != null){
      result.addAll({'freeRoomsNumber': freeRoomsNumber});
    }
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'electricityServiceIncluded': electricityServiceIncluded});
    result.addAll({'waterServiceIncluded': waterServiceIncluded});
    result.addAll({'internetServiceIncluded': internetServiceIncluded});
    result.addAll({'gazServiceIncluded': gazServiceIncluded});
    if(bedRooms != null){
      result.addAll({'bedRooms': bedRooms!.map((x) => x.toMap()).toList()});
    }
    if(rooms != null){
      result.addAll({'rooms': rooms!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      houseGender: map['houseGender'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      ownerName: map['ownerName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      bathRoomsNumber: map['bathRoomsNumber']?.toInt(),
      roomsNumber: map['roomsNumber']?.toInt(),
      freeRoomsNumber: map['freeRoomsNumber']?.toInt(),
      isFavorite: map['isFavorite'] ?? false,
      electricityServiceIncluded: map['electricityServiceIncluded'] ?? false,
      waterServiceIncluded: map['waterServiceIncluded'] ?? false,
      internetServiceIncluded: map['internetServiceIncluded'] ?? false,
      gazServiceIncluded: map['gazServiceIncluded'] ?? false,
      bedRooms: map['bedRooms'] != null ? List<BedRoomModel>.from(map['bedRooms']?.map((x) => BedRoomModel.fromMap(x))) : null,
      rooms: map['rooms'] != null ? List<RoomModel>.from(map['rooms']?.map((x) => RoomModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseModel.fromJson(String source) => HouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseModel(id: $id, address: $address, description: $description, houseGender: $houseGender, category: $category, location: $location, imgUrl: $imgUrl, ownerName: $ownerName, phoneNumber: $phoneNumber, bathRoomsNumber: $bathRoomsNumber, roomsNumber: $roomsNumber, freeRoomsNumber: $freeRoomsNumber, isFavorite: $isFavorite, electricityServiceIncluded: $electricityServiceIncluded, waterServiceIncluded: $waterServiceIncluded, internetServiceIncluded: $internetServiceIncluded, gazServiceIncluded: $gazServiceIncluded, bedRooms: $bedRooms, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HouseModel &&
      other.id == id &&
      other.address == address &&
      other.description == description &&
      other.houseGender == houseGender &&
      other.category == category &&
      other.location == location &&
      other.imgUrl == imgUrl &&
      other.ownerName == ownerName &&
      other.phoneNumber == phoneNumber &&
      other.bathRoomsNumber == bathRoomsNumber &&
      other.roomsNumber == roomsNumber &&
      other.freeRoomsNumber == freeRoomsNumber &&
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
      address.hashCode ^
      description.hashCode ^
      houseGender.hashCode ^
      category.hashCode ^
      location.hashCode ^
      imgUrl.hashCode ^
      ownerName.hashCode ^
      phoneNumber.hashCode ^
      bathRoomsNumber.hashCode ^
      roomsNumber.hashCode ^
      freeRoomsNumber.hashCode ^
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
    address: "نابلس - بيت وزن",
    houseGender: "طلاب",
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
    address: "نابلس - رفيديا",
    houseGender: "طالبات",
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
