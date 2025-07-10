import 'package:flutter/foundation.dart';
import 'package:roomality/database/room_db.dart';
import 'package:roomality/models/room.dart';

class HorPukProvider with ChangeNotifier {
  List<HorPuk> horPukData = [];

  bool isHorPukNameDuplicate(String horPukName) {
    return horPukData.any(
      (horPuk) => horPuk.horPukName.toLowerCase() == horPukName.toLowerCase(),
    );
  }

  Future<void> createHorPuk(horPukName, List<HorPukRow> rows) async {
    if (isHorPukNameDuplicate(horPukName)) {
      throw Exception(
        'ชื่อหอพัก "$horPukName" มีอยู่ในระบบแล้ว กรุณาใช้ชื่ออื่น',
      );
    }

    print(rows.length);
    for (var row in rows) {
      print("row.rowName = ${row.rowName}");
      print("row.floor.length = ${row.floor.length}");
      for (var floor in row.floor) {
        print("floor.floorName = ${floor.floorName}");
        print("floor.rooms.length = ${floor.rooms.length}");
        for (var room in floor.rooms) {
          print("room.roomName = ${room.roomName}");
        }
      }
    }
    // horPukData.add(HorPuk(horPukName: horPukName, rows: rows));
    // print(horPukData);

    await RoomDB(
      dbName: "rooms.db",
    ).insertHorPuk(HorPuk(horPukName: horPukName, rows: rows));
    print("insert to local Db successfully");
    horPukData.add(HorPuk(horPukName: horPukName, rows: rows));
    notifyListeners();
  }

  initHorPukData() async {
    var db = RoomDB(dbName: "rooms.db");
    List<HorPuk> horPukList = await db.loadAllHorPuk();
    horPukData = horPukList;
    notifyListeners();
  }
}
