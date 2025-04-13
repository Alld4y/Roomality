class Room {
  Room({
    required this.roomName,
    required this.monthlyPrice,
    required this.depositPrice,
    required this.rentalStartUnix,
    required this.contract,
    required this.paymentState,
  });
  String roomName;
  int monthlyPrice;
  int depositPrice;
  int rentalStartUnix;
  int contract;
  bool paymentState;
}

class SubRoom {
  final String roomName; // ชื่อห้อง เช่น ห้อง 101
  final int monthlyPrice;
  final int depositPrice;
  final int rentalStartUnix;
  final int contract;

  SubRoom({
    required this.roomName,
    required this.monthlyPrice,
    required this.depositPrice,
    required this.rentalStartUnix,
    required this.contract,
  });
}

class HorPuk {
  final String horPukName; // ชื่อหอพัก เช่น หอพัก Yaya
  final List<SubRoom> rooms; // ห้องทั้งหมดในหอนี้

  HorPuk({
    required this.horPukName,
    required this.rooms,
  });
}
List<Room> roomData = [
  Room(
    roomName: "101",
    monthlyPrice: 1000,
    depositPrice: 1200,
    rentalStartUnix: 1521255,
    contract: 12,
    paymentState: false,
  ),
  Room(
    roomName: "102",
    monthlyPrice: 1000,
    depositPrice: 1200,
    rentalStartUnix: 1521255,
    contract: 12,
    paymentState: false,
  ),
  Room(
    roomName: "102",
    monthlyPrice: 1000,
    depositPrice: 1200,
    rentalStartUnix: 1521255,
    contract: 12,
    paymentState: false,
  ),
];

List<HorPuk> horPukData = [HorPuk(
  horPukName: "Yaya",
  rooms: [
    SubRoom(roomName: "101", monthlyPrice: 1000, depositPrice: 3000, rentalStartUnix: 1251551, contract: 6),
    SubRoom(roomName: "102", monthlyPrice: 1000, depositPrice: 3000, rentalStartUnix: 1251551, contract: 6),
    SubRoom(roomName: "103", monthlyPrice: 1000, depositPrice: 3000, rentalStartUnix: 1251551, contract: 6),
  ],
  )];

