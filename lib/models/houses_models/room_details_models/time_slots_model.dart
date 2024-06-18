import 'dart:convert';

class TimeRequests {
  final String slotId;
  final String timeSlot;
  TimeRequests({
    required this.slotId,
    required this.timeSlot,
  });

  TimeRequests copyWith({
    String? slotId,
    String? timeSlot,
  }) {
    return TimeRequests(
      slotId: slotId ?? this.slotId,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'slotId': slotId});
    result.addAll({'timeSlot': timeSlot});

    return result;
  }

  factory TimeRequests.fromMap(Map<String, dynamic> map) {
    return TimeRequests(
      slotId: map['slotId']?.toString() ?? '',
      timeSlot: map['timeSlot'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeRequests.fromJson(String source) =>
      TimeRequests.fromMap(json.decode(source));

  @override
  String toString() => 'TimeRequests(slotId: $slotId, timeSlot: $timeSlot)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeRequests &&
        other.slotId == slotId &&
        other.timeSlot == timeSlot;
  }

  @override
  int get hashCode => slotId.hashCode ^ timeSlot.hashCode;
}
