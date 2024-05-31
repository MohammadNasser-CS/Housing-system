import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? colleqe;
  final String role;
  final String birthDate;
  final String? homeAddress;
  final String? universityBuilding;
  final String? specialization;
  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.colleqe,
    required this.role,
    required this.birthDate,
    this.homeAddress,
    this.universityBuilding,
    this.specialization,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? colleqe,
    String? role,
    String? birthDate,
    String? homeAddress,
    String? universityBuilding,
    String? specialization,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      colleqe: colleqe ?? this.colleqe,
      role: role ?? this.role,
      birthDate: birthDate ?? this.birthDate,
      homeAddress: homeAddress ?? this.homeAddress,
      universityBuilding: universityBuilding ?? this.universityBuilding,
      specialization: specialization ?? this.specialization,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    if (colleqe != null) {
      result.addAll({'colleqe': colleqe});
    }
    result.addAll({'role': role});
    result.addAll({'birthDate': birthDate});
    if (homeAddress != null) {
      result.addAll({'homeAddress': homeAddress});
    }
    if (universityBuilding != null) {
      result.addAll({'universityBuilding': universityBuilding});
    }
    if (specialization != null) {
      result.addAll({'specialization': specialization});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      colleqe: map['colleqe'],
      role: map['role'] ?? '',
      birthDate: map['birthDate'] ?? '',
      homeAddress: map['homeAddress'],
      universityBuilding: map['universityBuilding'],
      specialization: map['specialization'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phoneNumber: $phoneNumber, gender: $gender, colleqe: $colleqe, role: $role, birthDate: $birthDate, homeAddress: $homeAddress, universityBuilding: $universityBuilding, specialization: $specialization)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.gender == gender &&
        other.colleqe == colleqe &&
        other.role == role &&
        other.birthDate == birthDate &&
        other.homeAddress == homeAddress &&
        other.universityBuilding == universityBuilding &&
        other.specialization == specialization;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        gender.hashCode ^
        colleqe.hashCode ^
        role.hashCode ^
        birthDate.hashCode ^
        homeAddress.hashCode ^
        universityBuilding.hashCode ^
        specialization.hashCode;
  }
}

List<UserModel> dummyUsers = [
  UserModel(
    name: 'إسم المستخدم',
    email: 'abualnasser04@gmail.com',
    phoneNumber: '0568891980',
    gender: 'male',
    colleqe: 'IT',
    role: 'user',
    birthDate: '18-1-2003',
  ),
  UserModel(
    name: 'إسم المستخدم',
    email: 'abualnasser55@gmail.com',
    phoneNumber: '0561234567',
    gender: 'male',
    colleqe: null,
    role: 'houseOwner',
    birthDate: '28-10-2004',
  ),
];
