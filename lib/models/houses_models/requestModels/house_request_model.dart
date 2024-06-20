import 'dart:convert';

class HouseRequestModel {
  final String description;
  final String address;
  final String houseType;
  final String gender;
  final String location;
  final String internet;
  final String water;
  final String electricity;
  final String gas;
  HouseRequestModel({
    required this.description,
    required this.address,
    required this.houseType,
    required this.gender,
    required this.location,
    required this.internet,
    required this.water,
    required this.electricity,
    required this.gas,
  });
 

  HouseRequestModel copyWith({
    String? description,
    String? address,
    String? houseType,
    String? gender,
    String? location,
    String? internet,
    String? water,
    String? electricity,
    String? gas,
  }) {
    return HouseRequestModel(
      description: description ?? this.description,
      address: address ?? this.address,
      houseType: houseType ?? this.houseType,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      internet: internet ?? this.internet,
      water: water ?? this.water,
      electricity: electricity ?? this.electricity,
      gas: gas ?? this.gas,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'description': description});
    result.addAll({'address': address});
    result.addAll({'houseType': houseType});
    result.addAll({'gender': gender});
    result.addAll({'location': location});
    result.addAll({'internet': internet});
    result.addAll({'water': water});
    result.addAll({'electricity': electricity});
    result.addAll({'gas': gas});
  
    return result;
  }

  factory HouseRequestModel.fromMap(Map<String, dynamic> map) {
    return HouseRequestModel(
      description: map['description'] ?? '',
      address: map['address'] ?? '',
      houseType: map['houseType'] ?? '',
      gender: map['gender'] ?? '',
      location: map['location'] ?? '',
      internet: map['internet'] ?? '',
      water: map['water'] ?? '',
      electricity: map['electricity'] ?? '',
      gas: map['gas'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseRequestModel.fromJson(String source) => HouseRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseRequestModel(description: $description, address: $address, houseType: $houseType, gender: $gender, location: $location, internet: $internet, water: $water, electricity: $electricity, gas: $gas)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HouseRequestModel &&
      other.description == description &&
      other.address == address &&
      other.houseType == houseType &&
      other.gender == gender &&
      other.location == location &&
      other.internet == internet &&
      other.water == water &&
      other.electricity == electricity &&
      other.gas == gas;
  }

  @override
  int get hashCode {
    return description.hashCode ^
      address.hashCode ^
      houseType.hashCode ^
      gender.hashCode ^
      location.hashCode ^
      internet.hashCode ^
      water.hashCode ^
      electricity.hashCode ^
      gas.hashCode;
  }
}
