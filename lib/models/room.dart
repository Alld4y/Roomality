import 'package:flutter/material.dart';

enum PaymentStatus {
  complete(status: 2 ,icon: Icons.task_alt, iconColor: Color.fromRGBO(76, 175, 80, 1)),
  pending(status: 1 ,icon: Icons.pending_actions, iconColor: Color.fromRGBO(251, 192, 45, 1)),
  overDue(status: 3 ,icon:Icons.event_busy, iconColor: Colors.red),
  noTenant(status: 0 ,icon: Icons.person_search, iconColor: Color.fromRGBO(67, 34, 255, 1));
  const PaymentStatus({required this.icon, required this.iconColor,required this.status});
  final IconData icon;
  final Color iconColor;
  final int status;

  static PaymentStatus fromString(String? value){
    return PaymentStatus.values.firstWhere((e)=> e.name == value.toString(),
    orElse: ()=> PaymentStatus.noTenant);
  }
}

class Tenant {
  Tenant({
    required this.tenantName,
    required this.depositPrice,
    required this.rentalStartUnix,
    required this.contract,
    required this.paymentStatus,
  });

  String tenantName;
  int depositPrice;
  int rentalStartUnix;
  int contract;
  int paymentStatus;
}

class Room {
  Room({
    required this.roomName,
    required this.monthlyPrice,
    required this.roomStatus,
    timeStamp
    
  });
  String roomName;
  int monthlyPrice;
  DateTime timeStamp = DateTime.now();
  PaymentStatus roomStatus;
  Tenant? tenant;
  
  void addTenant(String tenantName,int depositPrice,int rentalStartUnix,int contract,int paymentStatus){
    tenant = Tenant(tenantName:tenantName ,depositPrice: depositPrice, rentalStartUnix: rentalStartUnix, contract: contract, paymentStatus: paymentStatus);
  }

  void deleteTenant(String confirm){
    if(confirm == "confirm"){
      tenant = null;
    }
  }

  Tenant? showTenant(){
    return tenant;
  }

  
 
}

class SubRoom {
  final String roomName; // ชื่อห้อง เช่น ห้อง 101
  final int monthlyPrice;
  final int depositPrice;
  final DateTime rentalStartUnix;
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
  Map<String,dynamic>toJson() => {
    "roomName": roomName,
    "monthlyPrice": monthlyPrice,
    "depositPrice": depositPrice,
    "paymentStatus":paymentStatus.name,
    "rentalStartUnix" :rentalStartUnix.toString(),
    "contract":contract
  };

  factory SubRoom.fromJson(Map<String, dynamic> json) => SubRoom(
    paymentStatus: PaymentStatus.fromString(json["paymentStatus"]),
    roomName: json["roomName"], 
    monthlyPrice: json["monthlyPrice"], 
    depositPrice: json["depositPrice"], 
    rentalStartUnix: DateTime.parse(json["rentalStartUnix"]), 
    contract: json["contract"]
    );
}

class HorPuk {
  final String horPukName; // ชื่อหอพัก เช่น หอพัก Yaya
  List<HorPukRow> rows; // 

  HorPuk({required this.horPukName, required this.rows});

  Map<String,dynamic>toJson() => {
    "horPukName": horPukName,
    "rows": rows.map((r)=>r.toJson()).toList(),
  };

  factory HorPuk.fromJson(Map<String,dynamic> json) => HorPuk(
    horPukName: json["horPukName"], 
    rows: List<HorPukRow>.from(json["rows"].map((r) => HorPukRow.fromJson(r))));
}

class HorPukRow {
  final String rowName;
  final List<HorPukFloor> floor;
  HorPukRow({required this.rowName, required this.floor});

  Map<String,dynamic>toJson()=>{
    "rowName": rowName,
    "floor": floor.map((f) => f.toJson()).toList(),
  };

  factory HorPukRow.fromJson(Map<String,dynamic>json) => HorPukRow(
    rowName: json["rowName"], 
    floor: List<HorPukFloor>.from(json["floor"].map((f)=>HorPukFloor.fromJson(f))),
  );
}

class HorPukFloor {
  final String floorName;
  final List<SubRoom> rooms;
  HorPukFloor({required this.floorName, required this.rooms});

  Map<String,dynamic>toJson() => {
    "floorName": floorName,
    "rooms": rooms.map((room) => room.toJson()).toList(),
  };

  factory HorPukFloor.fromJson(Map<String, dynamic>json) => HorPukFloor(
    floorName: json["floorName"], 
    rooms: List<SubRoom>.from(json["rooms"].map((room)=> SubRoom.fromJson(room))),
    );
}



