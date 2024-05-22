import 'dart:convert';

class NotificationModel {
  final String senderName;
  final String content;
  final String sinceTime;
  final String senderImg;
  NotificationModel({
    required this.senderName,
    required this.content,
    required this.sinceTime,
    required this.senderImg,
  });

  NotificationModel copyWith({
    String? senderName,
    String? content,
    String? sinceTime,
    String? senderImg,
  }) {
    return NotificationModel(
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      sinceTime: sinceTime ?? this.sinceTime,
      senderImg: senderImg ?? this.senderImg,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'senderName': senderName});
    result.addAll({'content': content});
    result.addAll({'sinceTime': sinceTime});
    result.addAll({'senderImg': senderImg});

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      senderName: map['senderName'] ?? '',
      content: map['content'] ?? '',
      sinceTime: map['sinceTime'] ?? '',
      senderImg: map['senderImg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(senderName: $senderName, content: $content, sinceTime: $sinceTime, senderImg: $senderImg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.senderName == senderName &&
        other.content == content &&
        other.sinceTime == sinceTime &&
        other.senderImg == senderImg;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
        content.hashCode ^
        sinceTime.hashCode ^
        senderImg.hashCode;
  }
}

List<NotificationModel> dummyNotification = [
  NotificationModel(
      senderName: 'محمد ناصر',
      content:
          'نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.',
      sinceTime: '3د',
      senderImg: 'assets/images/myphotocopy.jpg'),
  NotificationModel(
      senderName: 'محمد ناصر',
      content:
          'نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.',
      sinceTime: 'ساعة',
      senderImg: 'assets/images/myphotocopy.jpg'),
  NotificationModel(
      senderName: 'محمد ناصر',
      content:
          'نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.',
      sinceTime: '3 أيام',
      senderImg: 'assets/images/myphotocopy.jpg'),
  NotificationModel(
      senderName: 'محمد ناصر',
      content:
          'نود إعلامكم بوجود تحديث جديد على منصتنا. يتضمن التحديث تحسينات في الأداء وإضافة ميزات جديدة لتحسين تجربتكم. يرجى تحديث التطبيق للحصول على أفضل أداء والاستفادة من الميزات الجديدة.',
      sinceTime: 'يوم',
      senderImg: 'assets/images/myphotocopy.jpg'),
];
