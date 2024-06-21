import 'dart:convert';

import 'package:flutter/foundation.dart';

class RoomRequestsModel {
  final String requestId;
  final String requestStatus;
  final String? selectedDateTimeSlot;
  final String roomId;
  final String houseId;
  final String houseOwnerName;
  final String houseOwnerPhoneNumber;
  final String? studentName;
  final String? studentPhoneNumber;
  final Map<String, String>? availableTimes;
  RoomRequestsModel({
    required this.requestId,
    required this.requestStatus,
    this.selectedDateTimeSlot,
    required this.roomId,
    required this.houseId,
    required this.houseOwnerName,
    required this.houseOwnerPhoneNumber,
    this.studentName,
    this.studentPhoneNumber,
    this.availableTimes,
  });

  RoomRequestsModel copyWith({
    String? requestId,
    String? requestStatus,
    String? selectedDateTimeSlot,
    String? roomId,
    String? houseId,
    String? houseOwnerName,
    String? houseOwnerPhoneNumber,
    String? studentName,
    String? studentPhoneNumber,
    Map<String, String>? availableTimes,
  }) {
    return RoomRequestsModel(
      requestId: requestId ?? this.requestId,
      requestStatus: requestStatus ?? this.requestStatus,
      selectedDateTimeSlot: selectedDateTimeSlot ?? this.selectedDateTimeSlot,
      roomId: roomId ?? this.roomId,
      houseId: houseId ?? this.houseId,
      houseOwnerName: houseOwnerName ?? this.houseOwnerName,
      houseOwnerPhoneNumber:
          houseOwnerPhoneNumber ?? this.houseOwnerPhoneNumber,
      studentName: studentName ?? this.studentName,
      studentPhoneNumber: studentPhoneNumber ?? this.studentPhoneNumber,
      availableTimes: availableTimes ?? this.availableTimes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'requestId': requestId});
    result.addAll({'requestStatus': requestStatus});
    if (selectedDateTimeSlot != null) {
      result.addAll({'selectedDateTimeSlot': selectedDateTimeSlot});
    }
    result.addAll({'roomId': roomId});
    result.addAll({'houseId': houseId});
    result.addAll({'houseOwnerName': houseOwnerName});
    result.addAll({'houseOwnerPhoneNumber': houseOwnerPhoneNumber});
    if (studentName != null) {
      result.addAll({'studentName': studentName});
    }
    if (studentPhoneNumber != null) {
      result.addAll({'studentPhoneNumber': studentPhoneNumber});
    }
    if (availableTimes != null) {
      result.addAll({'availableTimes': availableTimes});
    }

    return result;
  }

  factory RoomRequestsModel.fromMap(Map<String, dynamic> map) {
    return RoomRequestsModel(
      requestId: map['requestId'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      selectedDateTimeSlot: map['selectedDateTimeSlot'],
      roomId: map['roomId'] ?? '',
      houseId: map['houseId'] ?? '',
      houseOwnerName: map['houseOwnerName'] ?? '',
      houseOwnerPhoneNumber: map['houseOwnerPhoneNumber'] ?? '',
      studentName: map['studentName'],
      studentPhoneNumber: map['studentPhoneNumber'],
      availableTimes: map['availableTimes'] != null
          ? Map<String, String>.from(map['availableTimes'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomRequestsModel.fromJson(String source) =>
      RoomRequestsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentRoomRequestsModel(requestId: $requestId, requestStatus: $requestStatus, selectedDateTimeSlot: $selectedDateTimeSlot, roomId: $roomId, houseId: $houseId, houseOwnerName: $houseOwnerName, houseOwnerPhoneNumber: $houseOwnerPhoneNumber, studentName: $studentName, studentPhoneNumber: $studentPhoneNumber, availableTimes: $availableTimes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomRequestsModel &&
        other.requestId == requestId &&
        other.requestStatus == requestStatus &&
        other.selectedDateTimeSlot == selectedDateTimeSlot &&
        other.roomId == roomId &&
        other.houseId == houseId &&
        other.houseOwnerName == houseOwnerName &&
        other.houseOwnerPhoneNumber == houseOwnerPhoneNumber &&
        other.studentName == studentName &&
        other.studentPhoneNumber == studentPhoneNumber &&
        mapEquals(other.availableTimes, availableTimes);
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        requestStatus.hashCode ^
        selectedDateTimeSlot.hashCode ^
        roomId.hashCode ^
        houseId.hashCode ^
        houseOwnerName.hashCode ^
        houseOwnerPhoneNumber.hashCode ^
        studentName.hashCode ^
        studentPhoneNumber.hashCode ^
        availableTimes.hashCode;
  }
}

List<RoomRequestsModel> dummyStdRoomRequests = [
  RoomRequestsModel(
    requestId: "3",
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '68',
    studentName: 'محمد ناصر',
    houseOwnerPhoneNumber: '0561234567',
    requestStatus: 'إختيار موعد',
    availableTimes: {
      '1': 'الأحد: 8-9',
      '2': 'الأحد: 9-10',
      '3': 'الأحد: 10-11',
      '4': 'الأحد: 1-2',
      '5': 'الأحد: 2-3',
      '6': 'الإثنين: 8-9',
      '7': 'الإثنين: 9-10',
      '8': 'الإثنين: 10-11',
      '9': 'الإثنين: 1-2',
      '10': 'الإثنين: 2-3',
      '11': 'الثلاثاء: 8-9',
      '12': 'الثلاثاء: 9-10',
      '13': 'الثلاثاء: 10-11',
      '14': 'الثلاثاء: 1-2',
      '15': 'الثلاثاء: 2-3',
      '16': 'الأربعاء: 8-9',
      '17': 'الأربعاء: 9-10',
      '18': 'الأربعاء: 10-11',
      '19': 'الأربعاء: 1-2',
      '20': 'الأربعاء: 2-3',
      '21': 'الخميس: 8-9',
      '22': 'الخميس: 9-10',
      '23': 'الخميس: 10-11',
      '24': 'الخميس: 1-2',
      '25': 'الخميس: 2-3',
    },
  ),
  RoomRequestsModel(
    requestId: "25",
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '70',
    studentName: 'محمد ناصر',
    houseOwnerPhoneNumber: '0561234567',
    requestStatus: 'تم تحديد موعد',
    availableTimes: {
      '1': 'الأحد: 8-9',
      '2': 'الأحد: 9-10',
      '3': 'الأحد: 10-11',
      '4': 'الأحد: 1-2',
      '5': 'الأحد: 2-3',
      '6': 'الإثنين: 8-9',
      '7': 'الإثنين: 9-10',
      '8': 'الإثنين: 10-11',
      '9': 'الإثنين: 1-2',
      '10': 'الإثنين: 2-3',
      '11': 'الثلاثاء: 8-9',
      '12': 'الثلاثاء: 9-10',
      '13': 'الثلاثاء: 10-11',
      '14': 'الثلاثاء: 1-2',
      '15': 'الثلاثاء: 2-3',
      '16': 'الأربعاء: 8-9',
      '17': 'الأربعاء: 9-10',
      '18': 'الأربعاء: 10-11',
      '19': 'الأربعاء: 1-2',
      '20': 'الأربعاء: 2-3',
      '21': 'الخميس: 8-9',
      '22': 'الخميس: 9-10',
      '23': 'الخميس: 10-11',
      '24': 'الخميس: 1-2',
      '25': 'الخميس: 2-3',
    },
  ),
];
