import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roomality/models/room.dart';
// ตรวจสอบว่าคุณ import model อื่นๆ เช่น HorPuk, Floor, Row ด้วยถ้ามีการใช้งาน

class ApiService {
  // baseUrl ได้รับการปรับให้ตรงกับ Bun.js server โดยที่ '/api' จะถูกเพิ่มใน Uri.parse() แทน
  static const String baseUrl =
      'http://192.168.0.229:3000'; // ไม่ต้องมี /api ต่อท้ายแล้ว
  // static const String apiKey = 'your_api_key'; // ลบบรรทัดนี้

  // Headers สำหรับ API requests
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    // 'Authorization': 'Bearer $apiKey', // ลบบรรทัดนี้
  };

  // ส่งข้อมูลห้องไปยัง server
  static Future<bool> sendRoomData(Room room) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/rooms'),
        headers: _headers,
        body: jsonEncode({
          'roomName': room.roomName,
          'monthlyPrice': room.monthlyPrice,
          'roomStatus': room.roomStatus.name,
          'createdAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Room data sent successfully: ${room.roomName}');
        return true;
      } else {
        print(
          'Failed to send room data: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      print('Error sending room data: $e');
      return false;
    }
  }

  // ส่งข้อมูลหอพักไปยัง server
  static Future<bool> sendHorPukData(HorPuk horPuk) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/horPuk/createHorPuk'), // เพิ่ม /api ที่นี่
        headers: _headers,
        body: jsonEncode({
          'horPukName': horPuk.horPukName,
          'rows':
              horPuk.rows
                  .map(
                    (row) => {
                      'rowName': row.rowName,
                      'floor':
                          row.floor
                              .map(
                                (floor) => {
                                  'floorName': floor.floorName,
                                  'rooms':
                                      floor.rooms
                                          .map(
                                            (room) => {
                                              'roomName': room.roomName,
                                              'monthlyPrice': room.monthlyPrice,
                                              'depositPrice': room.depositPrice,
                                              'rentalStartUnix':
                                                  room.rentalStartUnix
                                                      .toIso8601String(),
                                              'contract': room.contract,
                                              'paymentStatus':
                                                  room.paymentStatus.name,
                                            },
                                          )
                                          .toList(),
                                },
                              )
                              .toList(),
                    },
                  )
                  .toList(),
          'createdAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('HorPuk data sent successfully: ${horPuk.horPukName}');
        return true;
      } else {
        print(
          'Failed to send horpuk data: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      print('Error sending horpuk data: $e');
      return false;
    }
  }

  static Future userRegister(String username, String password, String email) async {
    try {
      final res = await http.post(
          Uri.parse('$baseUrl/api/user/register'),
          headers: _headers,
          body: jsonEncode({
            "username": username,
            "password": password,
            "email": email,
          })
        );

        if(res.statusCode == 200){
           print("200 is okay");
        }
    } catch (e) {
      print(e); 
    }
  }

  static Future<bool> userLogin(String username, String password) async {
    try {
      final res = await http.post(
          Uri.parse('$baseUrl/api/user/login'),
          headers: _headers,
          body: jsonEncode({
            "username": username,
            "password": password,
          })
      );
      if(res.statusCode == 500){
          print("Login Successfully");
          return true;
        }else{
          return false;
        }
    } catch (e) {
      print(e); 
      return false;
    }
  }

  // ดึงข้อมูลห้องจาก server
  static Future<List<Room>> getRoomsFromServer() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/rooms'), // เพิ่ม /api ที่นี่
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map(
              (json) => Room(
                roomName: json['roomName'],
                monthlyPrice: json['monthlyPrice'],
                roomStatus: PaymentStatus.fromString(json['roomStatus']),
              ),
            )
            .toList();
      } else {
        print('Failed to get rooms: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting rooms: $e');
      return [];
    }
  }

  // ดึงข้อมูลหอพักจาก server
  static Future<List<HorPuk>> getHorPukFromServer() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/horpuk'), // เพิ่ม /api ที่นี่
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => HorPuk.fromJson(json)).toList();
      } else {
        print('Failed to get horpuk: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting horpuk: $e');
      return [];
    }
  }

  static Future<void> syncAllData() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/sync'),
        headers: _headers,
        body: jsonEncode({'timestamp': DateTime.now().toIso8601String()}),
      );

      if (response.statusCode == 200) {
        print('Data sync completed successfully');
      } else {
        print('Data sync failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error syncing data: $e');
    }
  }
}
