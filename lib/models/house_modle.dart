import 'dart:convert';

class HouseModel {
  final String id;
  final String imgUrl;
  final String ownerName;
  final String description;
  final String category;
  final bool isFavorite;
  final String location;
  final int bathRoomsNumber;
  final int roomsNumber;
  final int freeRoomsNumber;
  HouseModel({
    required this.id,
    required this.imgUrl,
    required this.ownerName,
    required this.description,
    required this.category,
    required this.isFavorite,
    required this.location,
    required this.bathRoomsNumber,
    required this.roomsNumber,
    required this.freeRoomsNumber,
  });

  HouseModel copyWith({
    String? id,
    String? imgUrl,
    String? ownerName,
    String? description,
    String? category,
    bool? isFavorite,
    String? location,
    int? bathRoomsNumber,
    int? roomsNumber,
    int? freeRoomsNumber,
  }) {
    return HouseModel(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      ownerName: ownerName ?? this.ownerName,
      description: description ?? this.description,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      location: location ?? this.location,
      bathRoomsNumber: bathRoomsNumber ?? this.bathRoomsNumber,
      roomsNumber: roomsNumber ?? this.roomsNumber,
      freeRoomsNumber: freeRoomsNumber ?? this.freeRoomsNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'ownerName': ownerName});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'location': location});
    result.addAll({'bathRoomsNumber': bathRoomsNumber});
    result.addAll({'roomsNumber': roomsNumber});
    result.addAll({'freeRoomsNumber': freeRoomsNumber});

    return result;
  }

  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      ownerName: map['ownerName'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      location: map['location'] ?? '',
      bathRoomsNumber: map['bathRoomsNumber']?.toInt() ?? 0,
      roomsNumber: map['roomsNumber']?.toInt() ?? 0,
      freeRoomsNumber: map['freeRoomsNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseModel.fromJson(String source) =>
      HouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseModel(id: $id, imgUrl: $imgUrl, ownerName: $ownerName, description: $description, category: $category, isFavorite: $isFavorite, location: $location, bathRoomsNumber: $bathRoomsNumber, roomsNumber: $roomsNumber, freeRoomsNumber: $freeRoomsNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseModel &&
        other.id == id &&
        other.imgUrl == imgUrl &&
        other.ownerName == ownerName &&
        other.description == description &&
        other.category == category &&
        other.isFavorite == isFavorite &&
        other.location == location &&
        other.bathRoomsNumber == bathRoomsNumber &&
        other.roomsNumber == roomsNumber &&
        other.freeRoomsNumber == freeRoomsNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imgUrl.hashCode ^
        ownerName.hashCode ^
        description.hashCode ^
        category.hashCode ^
        isFavorite.hashCode ^
        location.hashCode ^
        bathRoomsNumber.hashCode ^
        roomsNumber.hashCode ^
        freeRoomsNumber.hashCode;
  }
}

List<HouseModel> dummyItems = [
  HouseModel(
      id: '1',
      imgUrl:
          'https://mostaql.hsoubcdn.com/uploads/thumbnails/532092/61924863e0137/9a8e4585198345.6030fcab71084.jpg',
      ownerName: 'محمد صالح',
      description: 'سكن جامعي',
      category: 'شقة',
      isFavorite: false,
      location: 'نابلس - شارع الجامعة',
      bathRoomsNumber: 2,
      roomsNumber: 5,
      freeRoomsNumber: 2),
  HouseModel(
      id: '2',
      imgUrl:
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/107181991.jpg?k=1057fc1d1e2128151fe7d135902d56462793d19a2d195b7386e204b5d85e2d0c&o=&hp=1',
      ownerName: 'خالد مصطفى',
      description: 'سكن جامعي',
      category: 'استوديو',
      isFavorite: false,
      location: 'نابلس',
      bathRoomsNumber: 2,
      roomsNumber: 5,
      freeRoomsNumber: 2),
];
