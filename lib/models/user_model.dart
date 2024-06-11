import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });
  

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'role': role});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      role.hashCode;
  }
}

// List<UserModel> dummyUsers = [
//   UserModel(
//     token: '120',
//     name: 'طالب 1',
//     email: 'abualnasser04@gmail.com',
//     phoneNumber: '0568891980',
//     gender: 'ذكر',
//     college: 'كلية الهندسة وتكنولوجيا المعلومات',
//     role: 'طالب',
//     birthDate: '18-1-2003',
//   ),
//   UserModel(
//     token: '122',
//     name: 'مالك 1',
//     email: 'abualnasser55@gmail.com',
//     phoneNumber: '0561234567',
//     gender: 'ذكر',
//     college: null,
//     role: 'صاحب سكن',
//     birthDate: '28-10-2004',
//   ),
//   UserModel(
//     token: '121',
//     name: 'مستخدم 1',
//     email: 'abualnasser05@gmail.com',
//     phoneNumber: '0561234567',
//     gender: 'ذكر',
//     college: null,
//     role: 'أدمن',
//     birthDate: '28-10-2004',
//   ),
// ];
