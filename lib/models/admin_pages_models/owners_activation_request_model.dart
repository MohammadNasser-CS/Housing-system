import 'dart:convert';

class OwnersActivationRequestModel {
  final String ownerId;
  final String name;
  final String phoneNumber;
  final String? royaltyPhoto;
  OwnersActivationRequestModel({
    required this.ownerId,
    required this.name,
    required this.phoneNumber,
    this.royaltyPhoto,
  });

  OwnersActivationRequestModel copyWith({
    String? ownerId,
    String? name,
    String? phoneNumber,
    String? royaltyPhoto,
  }) {
    return OwnersActivationRequestModel(
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      royaltyPhoto: royaltyPhoto ?? this.royaltyPhoto,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ownerId': ownerId});
    result.addAll({'name': name});
    result.addAll({'phoneNumber': phoneNumber});
    if (royaltyPhoto != null) {
      result.addAll({'royaltyPhoto': royaltyPhoto});
    }

    return result;
  }

  factory OwnersActivationRequestModel.fromMap(Map<String, dynamic> map) {
    return OwnersActivationRequestModel(
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      royaltyPhoto: map['royaltyPhoto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnersActivationRequestModel.fromJson(String source) =>
      OwnersActivationRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnersActivationRequestModel(ownerId: $ownerId, name: $name, phoneNumber: $phoneNumber, royaltyPhoto: $royaltyPhoto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnersActivationRequestModel &&
        other.ownerId == ownerId &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.royaltyPhoto == royaltyPhoto;
  }

  @override
  int get hashCode {
    return ownerId.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        royaltyPhoto.hashCode;
  }
}
