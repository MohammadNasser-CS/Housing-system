import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudentRoomRequestsModel {
  final String requestId;
  final String houseOwnerName;
  final String houseId;
  final String roomId;
  final String studentName;
  final String ownerPhoneNumber;
  final String requestStatus;
  final String? selectedDateTimeSlot;
  final Map<String, String> dateTimeSlots;
  StudentRoomRequestsModel({
    required this.requestId,
    required this.houseOwnerName,
    required this.houseId,
    required this.roomId,
    required this.studentName,
    required this.ownerPhoneNumber,
    required this.requestStatus,
    this.selectedDateTimeSlot,
    required this.dateTimeSlots,
  });

  StudentRoomRequestsModel copyWith({
    String? requestId,
    String? houseOwnerName,
    String? houseId,
    String? roomId,
    String? studentName,
    String? ownerPhoneNumber,
    String? requestStatus,
    String? selectedDateTimeSlot,
    Map<String, String>? dateTimeSlots,
  }) {
    return StudentRoomRequestsModel(
      requestId: requestId ?? this.requestId,
      houseOwnerName: houseOwnerName ?? this.houseOwnerName,
      houseId: houseId ?? this.houseId,
      roomId: roomId ?? this.roomId,
      studentName: studentName ?? this.studentName,
      ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
      requestStatus: requestStatus ?? this.requestStatus,
      selectedDateTimeSlot: selectedDateTimeSlot ?? this.selectedDateTimeSlot,
      dateTimeSlots: dateTimeSlots ?? this.dateTimeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'requestId': requestId});
    result.addAll({'houseOwnerName': houseOwnerName});
    result.addAll({'houseId': houseId});
    result.addAll({'roomId': roomId});
    result.addAll({'studentName': studentName});
    result.addAll({'ownerPhoneNumber': ownerPhoneNumber});
    result.addAll({'requestStatus': requestStatus});
    if(selectedDateTimeSlot != null){
      result.addAll({'selectedDateTimeSlot': selectedDateTimeSlot});
    }
    result.addAll({'dateTimeSlots': dateTimeSlots});
  
    return result;
  }

  factory StudentRoomRequestsModel.fromMap(Map<String, dynamic> map) {
    return StudentRoomRequestsModel(
      requestId: map['requestId'] ?? '',
      houseOwnerName: map['houseOwnerName'] ?? '',
      houseId: map['houseId'] ?? '',
      roomId: map['roomId'] ?? '',
      studentName: map['studentName'] ?? '',
      ownerPhoneNumber: map['ownerPhoneNumber'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      selectedDateTimeSlot: map['selectedDateTimeSlot'],
      dateTimeSlots: Map<String, String>.from(map['dateTimeSlots']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentRoomRequestsModel.fromJson(String source) => StudentRoomRequestsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentRoomRequestsModel(requestId: $requestId, houseOwnerName: $houseOwnerName, houseId: $houseId, roomId: $roomId, studentName: $studentName, ownerPhoneNumber: $ownerPhoneNumber, requestStatus: $requestStatus, selectedDateTimeSlot: $selectedDateTimeSlot, dateTimeSlots: $dateTimeSlots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StudentRoomRequestsModel &&
      other.requestId == requestId &&
      other.houseOwnerName == houseOwnerName &&
      other.houseId == houseId &&
      other.roomId == roomId &&
      other.studentName == studentName &&
      other.ownerPhoneNumber == ownerPhoneNumber &&
      other.requestStatus == requestStatus &&
      other.selectedDateTimeSlot == selectedDateTimeSlot &&
      mapEquals(other.dateTimeSlots, dateTimeSlots);
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
      houseOwnerName.hashCode ^
      houseId.hashCode ^
      roomId.hashCode ^
      studentName.hashCode ^
      ownerPhoneNumber.hashCode ^
      requestStatus.hashCode ^
      selectedDateTimeSlot.hashCode ^
      dateTimeSlots.hashCode;
  }
}

List<StudentRoomRequestsModel> dummyStdRoomRequests = [
  StudentRoomRequestsModel(
    requestId: "1",
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '1',
    studentName: 'محمد ناصر',
    ownerPhoneNumber: '0561234567',
    requestStatus: 'إختيار موعد',
    dateTimeSlots: {
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
  StudentRoomRequestsModel(
    requestId: "2",
    houseOwnerName: 'مالك 1',
    houseId: '1',
    roomId: '4',
    studentName: 'محمد ناصر',
    ownerPhoneNumber: '0561234567',
    requestStatus: 'تم تحديد موعد',
    dateTimeSlots: {
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
