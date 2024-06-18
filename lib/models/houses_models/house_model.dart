import 'dart:convert';

class HouseModel {
  final String houseId;
  final String houseType;
  final int? numberOfRooms;
  final String address;
  final String location;
  final int? availableRoom;
  final String ownerName;
  final String housePhoto;
  final bool isFavorite;
  HouseModel({
    required this.houseId,
    required this.houseType,
    this.numberOfRooms,
    required this.address,
    required this.location,
    this.availableRoom,
    required this.ownerName,
    required this.housePhoto,
    this.isFavorite = false,
  });

  HouseModel copyWith({
    String? houseId,
    String? houseType,
    int? numberOfRooms,
    String? address,
    String? location,
    int? availableRoom,
    String? ownerName,
    String? housePhoto,
    bool? isFavorite,
  }) {
    return HouseModel(
      houseId: houseId ?? this.houseId,
      houseType: houseType ?? this.houseType,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      address: address ?? this.address,
      location: location ?? this.location,
      availableRoom: availableRoom ?? this.availableRoom,
      ownerName: ownerName ?? this.ownerName,
      housePhoto: housePhoto ?? this.housePhoto,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'houseId': houseId});
    result.addAll({'houseType': houseType});
    if (numberOfRooms != null) {
      result.addAll({'numberOfRooms': numberOfRooms});
    }
    result.addAll({'address': address});
    result.addAll({'location': location});
    if (availableRoom != null) {
      result.addAll({'availableRoom': availableRoom});
    }
    result.addAll({'ownerName': ownerName});
    result.addAll({'imgUrl': housePhoto});
    result.addAll({'isFavorite': isFavorite});

    return result;
  }

  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      houseId: map['houseId']?.toString() ?? '',
      houseType: map['houseType'] ?? '',
      numberOfRooms: map['numberOfRooms']?.toInt(),
      address: map['address'] ?? '',
      location: map['location'] ?? '',
      availableRoom: map['availableRoom']?.toInt(),
      ownerName: map['ownerName'] ?? '',
      housePhoto: map['housePhoto'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseModel.fromJson(String source) =>
      HouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseModel(houseId: $houseId, houseType: $houseType, numberOfRooms: $numberOfRooms, address: $address, location: $location, availableRoom: $availableRoom, ownerName: $ownerName, housePhoto: $housePhoto, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseModel &&
        other.houseId == houseId &&
        other.houseType == houseType &&
        other.numberOfRooms == numberOfRooms &&
        other.address == address &&
        other.location == location &&
        other.availableRoom == availableRoom &&
        other.ownerName == ownerName &&
        other.housePhoto == housePhoto &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return houseId.hashCode ^
        houseType.hashCode ^
        numberOfRooms.hashCode ^
        address.hashCode ^
        location.hashCode ^
        availableRoom.hashCode ^
        ownerName.hashCode ^
        housePhoto.hashCode ^
        isFavorite.hashCode;
  }
}

List<HouseModel> dummyItems = [
  HouseModel(
    houseId: '1',
    address: "نابلس - بيت وزن",
    housePhoto:
        'https://mostaql.hsoubcdn.com/uploads/thumbnails/532092/61924863e0137/9a8e4585198345.6030fcab71084.jpg',
    ownerName: 'مالك 1',
    houseType: 'شقة',
    location: 'نابلس - شارع الجامعة',
  ),
  HouseModel(
    houseId: '2',
    address: "نابلس - رفيديا",
    housePhoto:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/107181991.jpg?k=1057fc1d1e2128151fe7d135902d56462793d19a2d195b7386e204b5d85e2d0c&o=&hp=1',
    ownerName: 'مالك 2',
    houseType: 'أستوديو',
    location: 'نابلس',
  ),
];
List<HouseModel> filterdHouses = dummyItems;
