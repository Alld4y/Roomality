import 'package:flutter/foundation.dart';
import 'package:roomality/database/room_db.dart';
import 'package:roomality/models/room.dart';
// import 'package:http/http.dart' as http;

class RoomProvider with ChangeNotifier {
  List<Room> roomData = [];

  bool isRoomNameDuplicate(String roomName) {
    return roomData.any(
      (room) => room.roomName.toLowerCase() == roomName.toLowerCase(),
    );
  }

  Future<void> createRoom(Room room) async {
    if (isRoomNameDuplicate(room.roomName)) {
      throw Exception(
        'ชื่อห้อง "$room.roomName" มีอยู่ในระบบแล้ว กรุณาใช้ชื่ออื่น',
      );
    }

    print("-----Create Room--------");
    roomData.add(room);

    var db = RoomDB(dbName: "rooms.db");
    await db.insertRoom(room);
    print("loadData -- >");
    roomData = await db.loadAllData();

    notifyListeners();
  }

  void initData() async {
    var db = RoomDB(dbName: "rooms.db");
    roomData = await db.loadAllData();
    notifyListeners();
  }
}
