import 'dart:convert';

class OwnerRegisterModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String gender;
  final String role;
  final String? base64Image;
  final String? imageExtension;
  OwnerRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.role,
    this.base64Image,
    this.imageExtension,
  });

  OwnerRegisterModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? gender,
    String? role,
    String? base64Image,
    String? imageExtension,
  }) {
    return OwnerRegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      base64Image: base64Image ?? this.base64Image,
      imageExtension: imageExtension ?? this.imageExtension,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    result.addAll({'role': role});
    if(base64Image != null){
      result.addAll({'base64Image': base64Image});
    }
    if(imageExtension != null){
      result.addAll({'imageExtension': imageExtension});
    }
  
    return result;
  }

  factory OwnerRegisterModel.fromMap(Map<String, dynamic> map) {
    return OwnerRegisterModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      base64Image: map['base64Image'],
      imageExtension: map['imageExtension'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerRegisterModel.fromJson(String source) => OwnerRegisterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnerRegisterModel(name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, gender: $gender, role: $role, base64Image: $base64Image, imageExtension: $imageExtension)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OwnerRegisterModel &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.role == role &&
      other.base64Image == base64Image &&
      other.imageExtension == imageExtension;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      role.hashCode ^
      base64Image.hashCode ^
      imageExtension.hashCode;
  }
}
