import 'package:flutter/material.dart';

enum PaymentStatus {
  complete(icon: Icons.task_alt, iconColor: Color.fromRGBO(76, 175, 80, 1)),
  pending(icon: Icons.pending_actions, iconColor: Color.fromRGBO(251, 192, 45, 1));
  const PaymentStatus({required this.icon, required this.iconColor});
  final IconData icon;
  final Color iconColor;
}

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
  PaymentStatus paymentStatus;

  SubRoom({
    required this.paymentStatus,
    required this.roomName,
    required this.monthlyPrice,
    required this.depositPrice,
    required this.rentalStartUnix,
    required this.contract,
  });
}

class HorPuk {
  final String horPukName; // ชื่อหอพัก เช่น หอพัก Yaya
  final List<HorPukRow> row; // ห้องทั้งหมดในหอนี้

  HorPuk({required this.horPukName, required this.row});
}

class HorPukRow {
  final String rowName;
  final List<HorPukFloor> floor;
  HorPukRow({required this.rowName, required this.floor});
}

class HorPukFloor {
  final String floorName;
  final List<SubRoom> rooms;
  HorPukFloor({required this.floorName, required this.rooms});
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

List<HorPuk> horPukData = [
  HorPuk(
    horPukName: "Yaya",
    row: [
      HorPukRow(
        rowName: "แถวที่ 1",
        floor: [
         HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
           SubRoom(
            roomName: "101",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.complete
          ),
          SubRoom(
            roomName: "102",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
             paymentStatus: PaymentStatus.pending
          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending
          ),
         ]),
        //   HorPukFloor(floorName: "ชั้นที่ 2", rooms: [
        //    SubRoom(
        //     roomName: "201",
        //     monthlyPrice: 1000,
        //     depositPrice: 3000,
        //     rentalStartUnix: 1251551,
        //     contract: 6,
        //   ),
        //   SubRoom(
        //     roomName: "202",
        //     monthlyPrice: 1000,
        //     depositPrice: 3000,
        //     rentalStartUnix: 1251551,
        //     contract: 6,
        //   ),
        //   SubRoom(
        //     roomName: "203",
        //     monthlyPrice: 1000,
        //     depositPrice: 3000,
        //     rentalStartUnix: 1251551,
        //     contract: 6,
        //   ),
        //  ])
        ],
      ),
      HorPukRow(rowName: "แถวที่ 2", floor: [
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
           SubRoom(
            roomName: "102",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending
          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
        ]),
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
           SubRoom(
            roomName: "102",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
        ]),

      ]),
      HorPukRow(rowName: "แถวที่ 3", floor: [
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
        ]),
  
      ])
    ],
  ),
  HorPuk(horPukName: "Ran", row: [
    HorPukRow(
      rowName: "แถวที่ 1",
      floor: [
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
        ]),
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),]),
      ],
    ),
    HorPukRow(
      rowName: "แถวที่ 2",
      floor: [
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),]),
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),]),
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),]),
      ],
    ),
    HorPukRow(
      rowName: "แถวที่ 3",
      floor: [
        HorPukFloor(floorName: "ชั้นที่ 1", rooms: [
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
          SubRoom(
            roomName: "103",
            monthlyPrice: 1000,
            depositPrice: 3000,
            rentalStartUnix: 1251551,
            contract: 6,
            paymentStatus: PaymentStatus.pending

          ),
        ]),
      ],
    ),
  ])
];
