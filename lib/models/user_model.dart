import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String? colleqe;
  final String role;
  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.colleqe,
    required this.role,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? colleqe,
    String? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      colleqe: colleqe ?? this.colleqe,
      role: role ?? this.role,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phoneNumber: $phoneNumber, gender: $gender, colleqe: $colleqe, role: $role)';
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
        other.role == role;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        gender.hashCode ^
        colleqe.hashCode ^
        role.hashCode;
  }
}

List<UserModel> dummyUsers = [
  UserModel(
      name: 'إسم المستخدم',
      email: 'abualnasser04@gmail.com',
      phoneNumber: '0568891980',
      gender: 'male',
      colleqe: 'IT',
      role: 'user'),
  UserModel(
      name: 'إسم المستخدم',
      email: 'abualnasser55@gmail.com',
      phoneNumber: '0561234567',
      gender: 'male',
      colleqe: null,
      role: 'houseOwner'),
];
