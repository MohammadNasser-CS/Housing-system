import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudentRoomRequestsModel {
  final String houseOwnerName;
  final String houseId;
  final String roomId;
  final String studentName;
  final String ownerPhoneNumber;
  final String requestStatus;
  final Map<String, List<String>> dateTimeSlots;
  StudentRoomRequestsModel({
    required this.houseOwnerName,
    required this.houseId,
    required this.roomId,
    required this.studentName,
    required this.ownerPhoneNumber,
    required this.requestStatus,
    required this.dateTimeSlots,
  });

  StudentRoomRequestsModel copyWith({
    String? houseOwnerName,
    String? houseId,
    String? roomId,
    String? studentName,
    String? ownerPhoneNumber,
    String? requestStatus,
    Map<String, List<String>>? dateTimeSlots,
  }) {
    return StudentRoomRequestsModel(
      houseOwnerName: houseOwnerName ?? this.houseOwnerName,
      houseId: houseId ?? this.houseId,
      roomId: roomId ?? this.roomId,
      studentName: studentName ?? this.studentName,
      ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
      requestStatus: requestStatus ?? this.requestStatus,
      dateTimeSlots: dateTimeSlots ?? this.dateTimeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'houseOwnerName': houseOwnerName});
    result.addAll({'houseId': houseId});
    result.addAll({'roomId': roomId});
    result.addAll({'studentName': studentName});
    result.addAll({'ownerPhoneNumber': ownerPhoneNumber});
    result.addAll({'requestStatus': requestStatus});
    result.addAll({'dateTimeSlots': dateTimeSlots});

    return result;
  }

  factory StudentRoomRequestsModel.fromMap(Map<String, dynamic> map) {
    return StudentRoomRequestsModel(
      houseOwnerName: map['houseOwnerName'] ?? '',
      houseId: map['houseId'] ?? '',
      roomId: map['roomId'] ?? '',
      studentName: map['studentName'] ?? '',
      ownerPhoneNumber: map['ownerPhoneNumber'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      dateTimeSlots: Map<String, List<String>>.from(map['dateTimeSlots']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentRoomRequestsModel.fromJson(String source) =>
      StudentRoomRequestsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentRoomRequestsMode(houseOwnerName: $houseOwnerName, houseId: $houseId, roomId: $roomId, studentName: $studentName, ownerPhoneNumber: $ownerPhoneNumber, requestStatus: $requestStatus, dateTimeSlots: $dateTimeSlots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentRoomRequestsModel &&
        other.houseOwnerName == houseOwnerName &&
        other.houseId == houseId &&
        other.roomId == roomId &&
        other.studentName == studentName &&
        other.ownerPhoneNumber == ownerPhoneNumber &&
        other.requestStatus == requestStatus &&
        mapEquals(other.dateTimeSlots, dateTimeSlots);
  }

  @override
  int get hashCode {
    return houseOwnerName.hashCode ^
        houseId.hashCode ^
        roomId.hashCode ^
        studentName.hashCode ^
        ownerPhoneNumber.hashCode ^
        requestStatus.hashCode ^
        dateTimeSlots.hashCode;
  }
}

List<StudentRoomRequestsModel> dummyStdRoomRequests = [
  StudentRoomRequestsModel(
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '1',
    studentName: 'محمد ناصر',
    ownerPhoneNumber: '0561234567',
    requestStatus: 'إختيار موعد',
    dateTimeSlots: {
      'الأحد': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ],
      'الإثنين': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ],
      'الثلاثاء': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ],
      'الأربعاء': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ],
      'الخميس': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ],
    },
  ),
  StudentRoomRequestsModel(
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '4',
    studentName: 'محمد ناصر',
    ownerPhoneNumber: '0561234567',
    requestStatus: 'تم تحديد موعد',
    dateTimeSlots: {
      'الأحد': [
        '8-9',
        '9-10',
        '10-12',
        '2-3',
        '3-4',
      ]
    },
  ),
];
