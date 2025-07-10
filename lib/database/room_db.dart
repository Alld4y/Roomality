import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roomality/models/room.dart';
import 'package:roomality/services/api_service.dart';
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
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<void> insertHorPuk(HorPuk horPuk) async {
    print("insert horPuk list");
    var db = await openDatabase();
    var store = intMapStoreFactory.store("horPuk");
      await store.add(db, horPuk.toJson());
      await ApiService.sendHorPukData(horPuk);
    print("Inserted $horPuk horPuk items");
  }

  Future<List<HorPuk>> loadAllHorPuk() async {
    print("Load All HorPuk List From Local Database Sembast");
    var db = await openDatabase();
    var store = intMapStoreFactory.store("horPuk");
    List<RecordSnapshot<int, Map<String, Object?>>> horPukSnapShot = await store.find(db);
    print("horPukSnapShot = $horPukSnapShot");
    print("horPukSnapShot.length = ${horPukSnapShot.length}");
    List<HorPuk> horPukList = horPukSnapShot.map((snapshot){
      final data = snapshot.value as Map<String,dynamic>;
      return HorPuk.fromJson(data);
    }).toList();
    return horPukList;
    // HorPukProvider().horPukData.addAll(horPukList);
    // print("HorPukProvider().horPukData = ${HorPukProvider().horPukData}");
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
      "roomStatus": room.roomStatus.name
    });  
    await ApiService.sendRoomData(room);

    return keyID;
  }

  Future<List<Room>> loadAllData() async {
    print("loadAllData");
    var db = await openDatabase();
    var store = intMapStoreFactory.store("rooms");
    var snapShot = await store.find(db);
    List<Room> roomList = [];
    
  
      for (var room in snapShot) {
        print('Room: ${room['roomName']}, Price: ${room['monthlyPrice']} ${DateTime.parse(room["timeStamp"].toString())} ${room["roomStatus"]}');
        roomList.add(Room(roomName: room["roomName"].toString(), monthlyPrice: int.parse(room["monthlyPrice"].toString()), timeStamp: room["timeStamp"], roomStatus: PaymentStatus.fromString(room["roomStatus"].toString())));
      }
      roomList.sort((a, b) => a.roomName.compareTo(b.roomName));
      print(roomList);
      return roomList;
    }
   

  deleteStore(String store) async {
    var db = await openDatabase();
    var st = intMapStoreFactory.store(store);
    await st.delete(db);
  }
}
