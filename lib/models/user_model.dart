import 'dart:convert';

class UserModel {
  final String token;
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? college;
  final String role;
  final String birthDate;
  final String? homeAddress;
  final String? universityBuilding;
  final String? specialization;
  UserModel({
    this.token = "",
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.college,
    required this.role,
    required this.birthDate,
    this.homeAddress,
    this.universityBuilding,
    this.specialization,
  });

  UserModel copyWith({
    String? token,
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? college,
    String? role,
    String? birthDate,
    String? homeAddress,
    String? universityBuilding,
    String? specialization,
  }) {
    return UserModel(
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      college: college ?? this.college,
      role: role ?? this.role,
      birthDate: birthDate ?? this.birthDate,
      homeAddress: homeAddress ?? this.homeAddress,
      universityBuilding: universityBuilding ?? this.universityBuilding,
      specialization: specialization ?? this.specialization,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'token': token});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    if (college != null) {
      result.addAll({'colleqe': college});
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
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ?? '',
      college: map['colleqe'],
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
    return 'UserModel(token: $token, name: $name, email: $email, phoneNumber: $phoneNumber, gender: $gender, colleqe: $college, role: $role, birthDate: $birthDate, homeAddress: $homeAddress, universityBuilding: $universityBuilding, specialization: $specialization)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.token == token &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.gender == gender &&
        other.college == college &&
        other.role == role &&
        other.birthDate == birthDate &&
        other.homeAddress == homeAddress &&
        other.universityBuilding == universityBuilding &&
        other.specialization == specialization;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        gender.hashCode ^
        college.hashCode ^
        role.hashCode ^
        birthDate.hashCode ^
        homeAddress.hashCode ^
        universityBuilding.hashCode ^
        specialization.hashCode;
  }
}

List<UserModel> dummyUsers = [
  UserModel(
    token: '120',
    name: 'طالب 1',
    email: 'abualnasser04@gmail.com',
    phoneNumber: '0568891980',
    gender: 'ذكر',
    college: 'كلية الهندسة وتكنولوجيا المعلومات',
    role: 'طالب',
    birthDate: '18-1-2003',
  ),
  UserModel(
    token: '122',
    name: 'مالك 1',
    email: 'abualnasser55@gmail.com',
    phoneNumber: '0561234567',
    gender: 'ذكر',
    college: null,
    role: 'صاحب سكن',
    birthDate: '28-10-2004',
  ),
  UserModel(
    token: '121',
    name: 'مستخدم 1',
    email: 'abualnasser05@gmail.com',
    phoneNumber: '0561234567',
    gender: 'ذكر',
    college: null,
    role: 'أدمن',
    birthDate: '28-10-2004',
  ),
];
