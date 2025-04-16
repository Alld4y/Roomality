
import 'package:flutter/foundation.dart';
import 'package:roomality/database/room_db.dart';
import 'package:roomality/models/room.dart';
// import 'package:http/http.dart' as http;

class RoomProvider with ChangeNotifier{
  
  List<Room> roomData = [];

  void createRoom(Room room) async {
    print("-----Create Room--------");
    roomData.add(room);

    var db = RoomDB(dbName: "rooms.db");
    await db.insertRoom(room);
    print("loadData -- >");
    roomData = await db.loadAllData();
    

    notifyListeners();
    // var data = {
    //   "roomName": room.roomName,
    //   "monthlyPrice": room.monthlyPrice,
    // };
    //  var url = Uri.http('192.168.0.73', "/createRoom");

    // ใช้ jsonEncode เพื่อแปลงข้อมูลเป็น JSON string
    // var response = await http.post(
    //   url,
    //   headers: {"Content-Type": "application/json"},
    //   body: jsonEncode(data),
    // );

    // print("response.body = ${response.body}");
    // print("response.statusCode = ${response.statusCode}");
  }
   void initData() async {
     var db = RoomDB(dbName: "rooms.db");
     roomData = await db.loadAllData();
     notifyListeners();
  }
  
}
