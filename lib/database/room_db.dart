import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roomality/models/room.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/sembast_import_export.dart';

class RoomDB{
  String dbName;
  RoomDB({required this.dbName});
  
  // Open Database
  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path,dbName);
    // Create Database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertRoom(Room room) async {
    print("insert Room");
    var db = await openDatabase();
    var store = intMapStoreFactory.store("rooms");
    print("store = $store");
    var keyID = await store.add(db, {
      "roomName": room.roomName,
      "monthlyPrice": room.monthlyPrice,
      "timeStamp": room.timeStamp.toIso8601String(),
    });
   

    return keyID;
  }

  Future<List<Room>> loadAllData() async {
    print("loadAllData");
    var db = await openDatabase();
    var store = intMapStoreFactory.store("rooms");
    var snapShot = await store.find(db);
    List<Room> roomList = [];
    
    for (var room in snapShot) {
        print('Room: ${room['roomName']}, Price: ${room['monthlyPrice']} ${DateTime.parse(room["timeStamp"].toString())}');
        roomList.add(Room(roomName: room["roomName"].toString(), monthlyPrice: int.parse(room["monthlyPrice"].toString()), timeStamp: room["timeStamp"]));
      }
      roomList.sort((a, b) => a.roomName.compareTo(b.roomName));
      print(roomList);
      return roomList;
  }

}
