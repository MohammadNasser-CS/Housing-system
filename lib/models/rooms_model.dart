import 'dart:convert';

class RoomModel {
  final String roomId;
  final String imageUrl;
  final int bedsNumber;
  final double roomSpace;
  final double roomPrice;
  final bool hasOffice;
  final bool electricityService;
  final bool waterService;
  final bool gasService;
  final String ownerStudentId;
  RoomModel({
    required this.roomId,
    required this.imageUrl,
    required this.bedsNumber,
    required this.roomSpace,
    required this.roomPrice,
    required this.hasOffice,
    required this.electricityService,
    required this.waterService,
    required this.gasService,
    required this.ownerStudentId,
  });

  RoomModel copyWith({
    String? roomId,
    String? imageUrl,
    int? bedsNumber,
    double? roomSpace,
    double? roomPrice,
    bool? hasOffice,
    bool? electricityService,
    bool? waterService,
    bool? gasService,
    String? ownerStudentId,
  }) {
    return RoomModel(
      roomId: roomId ?? this.roomId,
      imageUrl: imageUrl ?? this.imageUrl,
      bedsNumber: bedsNumber ?? this.bedsNumber,
      roomSpace: roomSpace ?? this.roomSpace,
      roomPrice: roomPrice ?? this.roomPrice,
      hasOffice: hasOffice ?? this.hasOffice,
      electricityService: electricityService ?? this.electricityService,
      waterService: waterService ?? this.waterService,
      gasService: gasService ?? this.gasService,
      ownerStudentId: ownerStudentId ?? this.ownerStudentId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'roomId': roomId});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'bedsNumber': bedsNumber});
    result.addAll({'roomSpace': roomSpace});
    result.addAll({'roomPrice': roomPrice});
    result.addAll({'hasOffice': hasOffice});
    result.addAll({'electricityService': electricityService});
    result.addAll({'waterService': waterService});
    result.addAll({'gasService': gasService});
    result.addAll({'ownerStudentId': ownerStudentId});

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      bedsNumber: map['bedsNumber']?.toInt() ?? 0,
      roomSpace: map['roomSpace']?.toDouble() ?? 0.0,
      roomPrice: map['roomPrice']?.toDouble() ?? 0.0,
      hasOffice: map['hasOffice'] ?? false,
      electricityService: map['electricityService'] ?? false,
      waterService: map['waterService'] ?? false,
      gasService: map['gasService'] ?? false,
      ownerStudentId: map['ownerStudentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(roomId: $roomId, imageUrl: $imageUrl, bedsNumber: $bedsNumber, roomSpace: $roomSpace, roomPrice: $roomPrice, hasOffice: $hasOffice, electricityService: $electricityService, waterService: $waterService, gasService: $gasService, ownerStudentId: $ownerStudentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.roomId == roomId &&
        other.imageUrl == imageUrl &&
        other.bedsNumber == bedsNumber &&
        other.roomSpace == roomSpace &&
        other.roomPrice == roomPrice &&
        other.hasOffice == hasOffice &&
        other.electricityService == electricityService &&
        other.waterService == waterService &&
        other.gasService == gasService &&
        other.ownerStudentId == ownerStudentId;
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        imageUrl.hashCode ^
        bedsNumber.hashCode ^
        roomSpace.hashCode ^
        roomPrice.hashCode ^
        hasOffice.hashCode ^
        electricityService.hashCode ^
        waterService.hashCode ^
        gasService.hashCode ^
        ownerStudentId.hashCode;
  }
}

List<RoomModel> dummyRooms = [
  RoomModel(
    roomId: '1',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386421.jpg?k=cc2ff60b160f3d20a23b369bb38ec248c88d014f3a08eb75daae696af2cc65be&o=&hp=1',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "1",
  ),
  RoomModel(
    roomId: '2',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345387185.jpg?k=a3accd05876ae7d2517d4263662b555a58cc333aeceed1e75ad12699a2b35fa1&o=&hp=1',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "2",
  ),
  RoomModel(
    roomId: '3',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386934.jpg?k=9d4201779fb0d9123d53667731b03037e9d84953f51574f8811e2eb7ec78486d&o=&hp=1',
    bedsNumber: 2,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "3",
  ),
  RoomModel(
    roomId: '4',
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/345386544.jpg?k=747464ad1d488e3073ec8a20992c023e31019725b51a4a8b211c878587b9294e&o=&hp=1',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "4",
  ),
  RoomModel(
    roomId: '5',
    imageUrl:
        'https://media-cdn.tripadvisor.com/media/vr-splice-j/05/81/2b/fe.jpg',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "5",
  ),
  RoomModel(
    roomId: '6',
    imageUrl:
        'https://q-xx.bstatic.com/xdata/images/hotel/max500/323204721.jpg?k=ce6460b9f23a9e4e88e149a279c9016fbc3745cd4a773682af3ccbf7e015780b&o=',
    bedsNumber: 0,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "6",
  ),
  RoomModel(
    roomId: '7',
    imageUrl:
        'https://st-andrew-s-guesthouse-ramallah.hotelmix.co.uk/data/Photos/OriginalPhoto/2214/221491/221491847/St-AndrewS-Guesthouse-Ramallah-Room.JPEG',
    bedsNumber: 0,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "7",
  ),
  RoomModel(
    roomId: '8',
    imageUrl:
        'https://mostaql.hsoubcdn.com/uploads/thumbnails/532092/61924863e0137/9a8e4585198345.6030fcab71084.jpg',
    bedsNumber: 1,
    roomSpace: 16,
    hasOffice: true,
    roomPrice: 50,
    electricityService: false,
    waterService: false,
    gasService: false,
    ownerStudentId: "8",
  ),
];
