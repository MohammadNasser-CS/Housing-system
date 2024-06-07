import 'dart:convert';

class OwnerRoomRequestsModel {
  final String requestId;
  final String studentName;
  final String studentPhoneNumber;
  final String ownerToken;
  final String ownerName;
  final String houseId;
  final String roomId;
  final String requestStatus;
  final String selectedDateTimeSlot;
  OwnerRoomRequestsModel({
    required this.requestId,
    required this.studentName,
    required this.studentPhoneNumber,
    required this.ownerToken,
    required this.ownerName,
    required this.houseId,
    required this.roomId,
    required this.requestStatus,
    required this.selectedDateTimeSlot,
  });

  OwnerRoomRequestsModel copyWith({
    String? requestId,
    String? studentName,
    String? studentPhoneNumber,
    String? ownerToken,
    String? ownerName,
    String? houseId,
    String? roomId,
    String? requestStatus,
    String? selectedDateTimeSlot,
  }) {
    return OwnerRoomRequestsModel(
      requestId: requestId ?? this.requestId,
      studentName: studentName ?? this.studentName,
      studentPhoneNumber: studentPhoneNumber ?? this.studentPhoneNumber,
      ownerToken: ownerToken ?? this.ownerToken,
      ownerName: ownerName ?? this.ownerName,
      houseId: houseId ?? this.houseId,
      roomId: roomId ?? this.roomId,
      requestStatus: requestStatus ?? this.requestStatus,
      selectedDateTimeSlot: selectedDateTimeSlot ?? this.selectedDateTimeSlot,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'requestId': requestId});
    result.addAll({'studentName': studentName});
    result.addAll({'studentPhoneNumber': studentPhoneNumber});
    result.addAll({'ownerToken': ownerToken});
    result.addAll({'ownerName': ownerName});
    result.addAll({'houseId': houseId});
    result.addAll({'roomId': roomId});
    result.addAll({'requestStatus': requestStatus});
    result.addAll({'selectedDateTimeSlot': selectedDateTimeSlot});

    return result;
  }

  factory OwnerRoomRequestsModel.fromMap(Map<String, dynamic> map) {
    return OwnerRoomRequestsModel(
      requestId: map['requestId'] ?? '',
      studentName: map['studentName'] ?? '',
      studentPhoneNumber: map['studentPhoneNumber'] ?? '',
      ownerToken: map['ownerToken'] ?? '',
      ownerName: map['ownerName'] ?? '',
      houseId: map['houseId'] ?? '',
      roomId: map['roomId'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      selectedDateTimeSlot: map['selectedDateTimeSlot'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerRoomRequestsModel.fromJson(String source) =>
      OwnerRoomRequestsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnerRoomRequestsModel(requestId: $requestId, studentName: $studentName, studentPhoneNumber: $studentPhoneNumber, ownerToken: $ownerToken, ownerName: $ownerName, houseId: $houseId, roomId: $roomId, requestStatus: $requestStatus, selectedDateTimeSlot: $selectedDateTimeSlot)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerRoomRequestsModel &&
        other.requestId == requestId &&
        other.studentName == studentName &&
        other.studentPhoneNumber == studentPhoneNumber &&
        other.ownerToken == ownerToken &&
        other.ownerName == ownerName &&
        other.houseId == houseId &&
        other.roomId == roomId &&
        other.requestStatus == requestStatus &&
        other.selectedDateTimeSlot == selectedDateTimeSlot;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        studentName.hashCode ^
        studentPhoneNumber.hashCode ^
        ownerToken.hashCode ^
        ownerName.hashCode ^
        houseId.hashCode ^
        roomId.hashCode ^
        requestStatus.hashCode ^
        selectedDateTimeSlot.hashCode;
  }
}

List<OwnerRoomRequestsModel> dummyOwnerRoomRequests = [
  OwnerRoomRequestsModel(
    requestId: "1",
    studentName: 'محمد ناصر',
    studentPhoneNumber: '0561234567',
    ownerToken: '122',
    ownerName: 'مالك 1',
    houseId: '1',
    roomId: '1',
    requestStatus: 'إختيار موعد',
    selectedDateTimeSlot: 'الخميس: 1-2',
  ),
  OwnerRoomRequestsModel(
    requestId: "2",
    studentName: 'محمد ناصر',
    studentPhoneNumber: '0561234567',
    ownerName: 'مالك 1',
    ownerToken: "122",
    houseId: '1',
    roomId: '4',
    requestStatus: 'تم تحديد موعد',
    selectedDateTimeSlot: 'الخميس: 9-10',
  ),
];
