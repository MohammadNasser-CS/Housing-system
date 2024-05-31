import 'dart:convert';

import 'package:flutter/foundation.dart';

class RoomModel {
  final String roomId;
  final List<String> imagesUrl;
  final String roomType;
  RoomModel({
    required this.roomId,
    required this.imagesUrl,
    required this.roomType,
  });

  RoomModel copyWith({
    String? roomId,
    List<String>? imagesUrl,
    String? roomType,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'roomId': roomId});
    result.addAll({'imagesUrl': imagesUrl});
    result.addAll({'roomType': roomType});

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? '',
      imagesUrl: List<String>.from(map['imagesUrl']),
      roomType: map['roomType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RoomModel(roomId: $roomId, imagesUrl: $imagesUrl, roomType: $roomType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.roomId == roomId &&
        listEquals(other.imagesUrl, imagesUrl) &&
        other.roomType == roomType;
  }

  @override
  int get hashCode => roomId.hashCode ^ imagesUrl.hashCode ^ roomType.hashCode;
}

class BedRoomModel extends RoomModel {
  final int bedsNumber;
  final String studentName;
  final String studentId;
  final String houseOwnerName;
  final String houseOwnerId;
  final int freeBeds;
  final double roomSpace;
  final double roomPrice;
  final bool hasOffice;
  final bool hasAc;
  final bool hasBalcony;
  BedRoomModel({
    required super.roomId,
    required super.imagesUrl,
    required super.roomType,
    required this.bedsNumber,
    required this.freeBeds,
    required this.roomSpace,
    required this.roomPrice,
    required this.hasOffice,
    required this.hasAc,
    required this.hasBalcony,
    required this.houseOwnerId,
    required this.houseOwnerName,
    required this.studentId,
    required this.studentName,
  });

  @override
  BedRoomModel copyWith({
    String? roomId,
    List<String>? imagesUrl,
    String? roomType,
    int? bedsNumber,
    int? freeBeds,
    double? roomSpace,
    double? roomPrice,
    bool? hasOffice,
    bool? hasAc,
    bool? hasBalcony,
    String? studentName,
    String? studentId,
    String? houseOwnerName,
    String? houseOwnerId,
  }) {
    return BedRoomModel(
      roomId: roomId ?? this.roomId,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      roomType: roomType ?? this.roomType,
      bedsNumber: bedsNumber ?? this.bedsNumber,
      freeBeds: freeBeds ?? this.freeBeds,
      roomSpace: roomSpace ?? this.roomSpace,
      roomPrice: roomPrice ?? this.roomPrice,
      hasOffice: hasOffice ?? this.hasOffice,
      hasAc: hasAc ?? this.hasAc,
      hasBalcony: hasBalcony ?? this.hasBalcony,
      studentName: studentName ?? this.studentName,
      studentId: studentId ?? this.studentId,
      houseOwnerName: houseOwnerName ?? this.houseOwnerName,
      houseOwnerId: houseOwnerId ?? this.houseOwnerId,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'roomId': roomId});
    result.addAll({'imagesUrl': imagesUrl});
    result.addAll({'roomType': roomType});
    result.addAll({'bedsNumber': bedsNumber});
    result.addAll({'freeBeds': freeBeds});
    result.addAll({'roomSpace': roomSpace});
    result.addAll({'roomPrice': roomPrice});
    result.addAll({'hasOffice': hasOffice});
    result.addAll({'hasAc': hasAc});
    result.addAll({'hasBalcony': hasBalcony});
    result.addAll({'studentName': studentName});
    result.addAll({'studentId': studentId});
    result.addAll({'houseOwnerName': houseOwnerName});
    result.addAll({'houseOwnerId': houseOwnerId});

    return result;
  }

  factory BedRoomModel.fromMap(Map<String, dynamic> map) {
    return BedRoomModel(
      roomId: map['roomId'] ?? '',
      imagesUrl: List<String>.from(map['imagesUrl']),
      roomType: map['roomType'] ?? '',
      bedsNumber: map['bedsNumber']?.toInt() ?? 0,
      freeBeds: map['freeBeds']?.toInt() ?? 0,
      roomSpace: map['roomSpace']?.toDouble() ?? 0.0,
      roomPrice: map['roomPrice']?.toDouble() ?? 0.0,
      hasOffice: map['hasOffice'] ?? false,
      hasAc: map['hasAc'] ?? false,
      hasBalcony: map['hasBalcony'] ?? false,
      studentName: map['studentName'] ?? '',
      studentId: map['studentId'] ?? '',
      houseOwnerName: map['houseOwnerNamemap'] ?? '',
      houseOwnerId: map['houseOwnerId'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory BedRoomModel.fromJson(String source) =>
      BedRoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BedRoomModel(roomId: $roomId, imagesUrl: $imagesUrl, roomType: $roomType, bedsNumber: $bedsNumber, freeBeds: $freeBeds, roomSpace: $roomSpace, roomPrice: $roomPrice, hasOffice: $hasOffice, hasAc: $hasAc, hasBalcony: $hasBalcony)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BedRoomModel &&
        other.roomId == roomId &&
        listEquals(other.imagesUrl, imagesUrl) &&
        other.roomType == roomType &&
        other.bedsNumber == bedsNumber &&
        other.freeBeds == freeBeds &&
        other.roomSpace == roomSpace &&
        other.roomPrice == roomPrice &&
        other.hasOffice == hasOffice &&
        other.hasAc == hasAc &&
        other.hasBalcony == hasBalcony;
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        imagesUrl.hashCode ^
        roomType.hashCode ^
        bedsNumber.hashCode ^
        freeBeds.hashCode ^
        roomSpace.hashCode ^
        roomPrice.hashCode ^
        hasOffice.hashCode ^
        hasAc.hashCode ^
        hasBalcony.hashCode;
  }
}

List<BedRoomModel> dummyBedRooms = [
  BedRoomModel(
    roomId: '1',
    imagesUrl: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386421.jpg?k=cc2ff60b160f3d20a23b369bb38ec248c88d014f3a08eb75daae696af2cc65be&o=&hp=1'
    ],
    houseOwnerId: '147',
    houseOwnerName: 'مالك 1',
    studentId: '120',
    studentName: 'طالب 1',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    roomType: 'غرفة نوم',
    freeBeds: 1,
    hasAc: false,
    hasBalcony: false,
  ),
  BedRoomModel(
    roomId: '4',
    imagesUrl: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386544.jpg?k=747464ad1d488e3073ec8a20992c023e31019725b51a4a8b211c878587b9294e&o=&hp=1'
    ],
    houseOwnerId: '369',
    houseOwnerName: 'مالك 2',
    studentId: '121',
    studentName: 'طالب 2',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    roomType: 'غرفة نوم',
    freeBeds: 1,
    hasAc: false,
    hasBalcony: false,
  ),
  BedRoomModel(
    roomId: '5',
    imagesUrl: [
      'https://media-cdn.tripadvisor.com/media/vr-splice-j/05/81/2b/fe.jpg'
    ],
    houseOwnerId: '258',
    houseOwnerName: 'مالك 3',
    studentId: '122',
    studentName: 'طالب 3',
    bedsNumber: 2,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    roomType: 'غرفة نوم',
    freeBeds: 2,
    hasAc: false,
    hasBalcony: false,
  ),
];
List<RoomModel> dummyRooms = [
  RoomModel(
    roomId: '2',
    imagesUrl: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345387185.jpg?k=a3accd05876ae7d2517d4263662b555a58cc333aeceed1e75ad12699a2b35fa1&o=&hp=1'
    ],
    roomType: 'ثانوية',
  ),
  RoomModel(
    roomId: '3',
    imagesUrl: [
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386934.jpg?k=9d4201779fb0d9123d53667731b03037e9d84953f51574f8811e2eb7ec78486d&o=&hp=1'
    ],
    roomType: 'ثانوية',
  ),
  RoomModel(
    roomId: '6',
    imagesUrl: [
      'https://q-xx.bstatic.com/xdata/images/hotel/max500/323204721.jpg?k=ce6460b9f23a9e4e88e149a279c9016fbc3745cd4a773682af3ccbf7e015780b&o='
    ],
    roomType: 'ثانوية',
  ),
  RoomModel(
    roomId: '7',
    imagesUrl: [
      'https://st-andrew-s-guesthouse-ramallah.hotelmix.co.uk/data/Photos/OriginalPhoto/2214/221491/221491847/St-AndrewS-Guesthouse-Ramallah-Room.JPEG'
    ],
    roomType: 'ثانوية',
  ),
];
