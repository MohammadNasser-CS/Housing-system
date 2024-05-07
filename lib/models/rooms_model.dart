import 'dart:convert';

class RoomModel {
  final String roomId;
  final String imageUrl;
 const  RoomModel({
    required this.roomId,
    required this.imageUrl,
  });

  RoomModel copyWith({
    String? roomId,
    String? imageUrl,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'roomId': roomId});
    result.addAll({'imageUrl': imageUrl});

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() => 'RoomModel(roomId: $roomId, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.roomId == roomId &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => roomId.hashCode ^ imageUrl.hashCode;
}

List<RoomModel> dummyRooms =const [
  RoomModel(
    roomId: '1',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386421.jpg?k=cc2ff60b160f3d20a23b369bb38ec248c88d014f3a08eb75daae696af2cc65be&o=&hp=1',
  ),
  RoomModel(
    roomId: '2',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345387185.jpg?k=a3accd05876ae7d2517d4263662b555a58cc333aeceed1e75ad12699a2b35fa1&o=&hp=1',
  ),
  RoomModel(
    roomId: '3',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386934.jpg?k=9d4201779fb0d9123d53667731b03037e9d84953f51574f8811e2eb7ec78486d&o=&hp=1',
  ),
  RoomModel(
    roomId: '4',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386544.jpg?k=747464ad1d488e3073ec8a20992c023e31019725b51a4a8b211c878587b9294e&o=&hp=1',
  ),
  RoomModel(
    roomId: '5',
    imageUrl:
        'https://media-cdn.tripadvisor.com/media/vr-splice-j/05/81/2b/fe.jpg',
  ),
  RoomModel(
    roomId: '6',
    imageUrl:
        'https://q-xx.bstatic.com/xdata/images/hotel/max500/323204721.jpg?k=ce6460b9f23a9e4e88e149a279c9016fbc3745cd4a773682af3ccbf7e015780b&o=',
  ),
  RoomModel(
    roomId: '7',
    imageUrl:
        'https://st-andrew-s-guesthouse-ramallah.hotelmix.co.uk/data/Photos/OriginalPhoto/2214/221491/221491847/St-AndrewS-Guesthouse-Ramallah-Room.JPEG',
  ),
  RoomModel(
    roomId: '8',
    imageUrl:
        'https://mostaql.hsoubcdn.com/uploads/thumbnails/532092/61924863e0137/9a8e4585198345.6030fcab71084.jpg',
  ),
];
