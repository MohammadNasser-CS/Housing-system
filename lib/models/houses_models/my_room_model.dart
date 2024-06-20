import 'dart:convert';

class MyRoomModel {
  final String reservationType;
  final String reservationEnd;
  final String houseOwnerName;
  final String houseOwnerPhone;
  final String roomPhoto;
  final String price;
  final String roomSpace;
  final String availableBeds;
  final String hasBalcony;
  final String hasDesk;
  final String hasAc;
  MyRoomModel({
    required this.reservationType,
    required this.reservationEnd,
    required this.houseOwnerName,
    required this.houseOwnerPhone,
    required this.roomPhoto,
    required this.price,
    required this.roomSpace,
    required this.availableBeds,
    required this.hasBalcony,
    required this.hasDesk,
    required this.hasAc,
  });
 

  MyRoomModel copyWith({
    String? reservationType,
    String? reservationEnd,
    String? houseOwnerName,
    String? houseOwnerPhone,
    String? roomPhoto,
    String? price,
    String? roomSpace,
    String? availableBeds,
    String? hasBalcony,
    String? hasDesk,
    String? hasAc,
  }) {
    return MyRoomModel(
      reservationType: reservationType ?? this.reservationType,
      reservationEnd: reservationEnd ?? this.reservationEnd,
      houseOwnerName: houseOwnerName ?? this.houseOwnerName,
      houseOwnerPhone: houseOwnerPhone ?? this.houseOwnerPhone,
      roomPhoto: roomPhoto ?? this.roomPhoto,
      price: price ?? this.price,
      roomSpace: roomSpace ?? this.roomSpace,
      availableBeds: availableBeds ?? this.availableBeds,
      hasBalcony: hasBalcony ?? this.hasBalcony,
      hasDesk: hasDesk ?? this.hasDesk,
      hasAc: hasAc ?? this.hasAc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'reservationType': reservationType});
    result.addAll({'reservationEnd': reservationEnd});
    result.addAll({'houseOwnerName': houseOwnerName});
    result.addAll({'houseOwnerPhone': houseOwnerPhone});
    result.addAll({'roomPhoto': roomPhoto});
    result.addAll({'price': price});
    result.addAll({'roomSpace': roomSpace});
    result.addAll({'availableBeds': availableBeds});
    result.addAll({'hasBalcony': hasBalcony});
    result.addAll({'hasDesk': hasDesk});
    result.addAll({'hasAc': hasAc});
  
    return result;
  }

  factory MyRoomModel.fromMap(Map<String, dynamic> map) {
    return MyRoomModel(
      reservationType: map['reservationType'] ?? '',
      reservationEnd: map['reservationEnd'] ?? '',
      houseOwnerName: map['houseOwnerName'] ?? '',
      houseOwnerPhone: map['houseOwnerPhone'] ?? '',
      roomPhoto: map['roomPhoto'] ?? '',
      price: map['price'] ?? '',
      roomSpace: map['roomSpace'] ?? '',
      availableBeds: map['availableBeds'] ?? '',
      hasBalcony: map['hasBalcony'] ?? '',
      hasDesk: map['hasDesk'] ?? '',
      hasAc: map['hasAc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRoomModel.fromJson(String source) => MyRoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRoomModel(reservationType: $reservationType, reservationEnd: $reservationEnd, houseOwnerName: $houseOwnerName, houseOwnerPhone: $houseOwnerPhone, roomPhoto: $roomPhoto, price: $price, roomSpace: $roomSpace, availableBeds: $availableBeds, hasBalcony: $hasBalcony, hasDesk: $hasDesk, hasAc: $hasAc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyRoomModel &&
      other.reservationType == reservationType &&
      other.reservationEnd == reservationEnd &&
      other.houseOwnerName == houseOwnerName &&
      other.houseOwnerPhone == houseOwnerPhone &&
      other.roomPhoto == roomPhoto &&
      other.price == price &&
      other.roomSpace == roomSpace &&
      other.availableBeds == availableBeds &&
      other.hasBalcony == hasBalcony &&
      other.hasDesk == hasDesk &&
      other.hasAc == hasAc;
  }

  @override
  int get hashCode {
    return reservationType.hashCode ^
      reservationEnd.hashCode ^
      houseOwnerName.hashCode ^
      houseOwnerPhone.hashCode ^
      roomPhoto.hashCode ^
      price.hashCode ^
      roomSpace.hashCode ^
      availableBeds.hashCode ^
      hasBalcony.hashCode ^
      hasDesk.hashCode ^
      hasAc.hashCode;
  }
}
