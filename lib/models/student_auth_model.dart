import 'dart:convert';

class StudentRegisterModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String gender;
  final String college;
  final String role;
  final String birthDate;
  final String universityBuilding;
  final String specialization;
  StudentRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.college,
    required this.role,
    required this.birthDate,
    required this.universityBuilding,
    required this.specialization,
  });

  StudentRegisterModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? gender,
    String? college,
    String? role,
    String? birthDate,
    String? universityBuilding,
    String? specialization,
  }) {
    return StudentRegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      college: college ?? this.college,
      role: role ?? this.role,
      birthDate: birthDate ?? this.birthDate,
      universityBuilding: universityBuilding ?? this.universityBuilding,
      specialization: specialization ?? this.specialization,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    result.addAll({'college': college});
    result.addAll({'role': role});
    result.addAll({'birthDate': birthDate});
    result.addAll({'universityBuilding': universityBuilding});
    result.addAll({'specialization': specialization});
  
    return result;
  }

  factory StudentRegisterModel.fromMap(Map<String, dynamic> map) {
    return StudentRegisterModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      college: map['college'] ?? '',
      role: map['role'] ?? '',
      birthDate: map['birthDate'] ?? '',
      universityBuilding: map['universityBuilding'] ?? '',
      specialization: map['specialization'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentRegisterModel.fromJson(String source) => StudentRegisterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentRegisterModel(name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, gender: $gender, college: $college, role: $role, birthDate: $birthDate, universityBuilding: $universityBuilding, specialization: $specialization)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StudentRegisterModel &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.college == college &&
      other.role == role &&
      other.birthDate == birthDate &&
      other.universityBuilding == universityBuilding &&
      other.specialization == specialization;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      college.hashCode ^
      role.hashCode ^
      birthDate.hashCode ^
      universityBuilding.hashCode ^
      specialization.hashCode;
  }
}
