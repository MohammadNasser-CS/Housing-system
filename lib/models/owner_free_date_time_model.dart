import 'dart:convert';

class OwnerFreeDateTimeModel {
  final String? dateTimeSlotId;
  final String? dayName;
  String? startTime;
  String? endTime;
  bool included;
  OwnerFreeDateTimeModel({
    this.dateTimeSlotId,
    this.dayName,
    this.startTime,
    this.endTime,
    this.included = false,
  });

  OwnerFreeDateTimeModel copyWith({
    String? dateTimeSlotId,
    String? dayName,
    String? startTime,
    String? endTime,
    bool? included,
  }) {
    return OwnerFreeDateTimeModel(
      dateTimeSlotId: dateTimeSlotId ?? this.dateTimeSlotId,
      dayName: dayName ?? this.dayName,
      startTime: startTime,
      endTime: endTime,
      included: included ?? this.included,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (dateTimeSlotId != null) {
      result.addAll({'dateTimeSlotId': dateTimeSlotId});
    }
    if (dayName != null) {
      result.addAll({'dayName': dayName});
    }
    if (startTime != null) {
      result.addAll({'startTime': startTime});
    }
    if (endTime != null) {
      result.addAll({'endTime': endTime});
    }
    result.addAll({'included': included});

    return result;
  }

  factory OwnerFreeDateTimeModel.fromMap(Map<String, dynamic> map) {
    return OwnerFreeDateTimeModel(
      dateTimeSlotId: map['dateTimeSlotId'],
      dayName: map['dayName'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      included: map['included'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerFreeDateTimeModel.fromJson(String source) =>
      OwnerFreeDateTimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OwnerFreeDateTimeModel(dateTimeSlotId: $dateTimeSlotId, dayName: $dayName, startTime: $startTime, endTime: $endTime, included: $included)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerFreeDateTimeModel &&
        other.dateTimeSlotId == dateTimeSlotId &&
        other.dayName == dayName &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.included == included;
  }

  @override
  int get hashCode {
    return dateTimeSlotId.hashCode ^
        dayName.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        included.hashCode;
  }
}

List<OwnerFreeDateTimeModel> days = [
  OwnerFreeDateTimeModel(dateTimeSlotId: '1', dayName: 'السبت'),
  OwnerFreeDateTimeModel(dateTimeSlotId: '2', dayName: 'الأحد'),
  OwnerFreeDateTimeModel(dateTimeSlotId: '3', dayName: 'الإثنين'),
  OwnerFreeDateTimeModel(dateTimeSlotId: '4', dayName: 'الثلاثاء'),
  OwnerFreeDateTimeModel(dateTimeSlotId: '5', dayName: 'الأربعاء'),
  OwnerFreeDateTimeModel(dateTimeSlotId: '6', dayName: 'الخميس'),
];
List<OwnerFreeDateTimeModel> dayss = [];
