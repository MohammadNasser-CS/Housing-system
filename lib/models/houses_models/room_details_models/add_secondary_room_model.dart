import 'dart:convert';

class AddSecondaryRoom {
   final String houseId;
   final String roomType;
   final String base64Image;
  final String imageExtension;
  AddSecondaryRoom({
    required this.houseId,
    required this.roomType,
    required this.base64Image,
    required this.imageExtension,
  });

  AddSecondaryRoom copyWith({
    String? houseId,
    String? roomType,
    String? base64Image,
    String? imageExtension,
  }) {
    return AddSecondaryRoom(
      houseId: houseId ?? this.houseId,
      roomType: roomType ?? this.roomType,
      base64Image: base64Image ?? this.base64Image,
      imageExtension: imageExtension ?? this.imageExtension,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'houseId': houseId});
    result.addAll({'roomType': roomType});
    result.addAll({'base64Image': base64Image});
    result.addAll({'imageExtension': imageExtension});
  
    return result;
  }

  factory AddSecondaryRoom.fromMap(Map<String, dynamic> map) {
    return AddSecondaryRoom(
      houseId: map['houseId'] ?? '',
      roomType: map['roomType'] ?? '',
      base64Image: map['base64Image'] ?? '',
      imageExtension: map['imageExtension'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddSecondaryRoom.fromJson(String source) => AddSecondaryRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddSecondaryRoom(houseId: $houseId, roomType: $roomType, base64Image: $base64Image, imageExtension: $imageExtension)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddSecondaryRoom &&
      other.houseId == houseId &&
      other.roomType == roomType &&
      other.base64Image == base64Image &&
      other.imageExtension == imageExtension;
  }

  @override
  int get hashCode {
    return houseId.hashCode ^
      roomType.hashCode ^
      base64Image.hashCode ^
      imageExtension.hashCode;
  }
}
