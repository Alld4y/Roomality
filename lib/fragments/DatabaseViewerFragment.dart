import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/database/room_db.dart';
import 'package:roomality/models/room.dart';

class DatabaseViewerFragment extends StatefulWidget {
  const DatabaseViewerFragment({super.key});

  @override
  State<DatabaseViewerFragment> createState() => _DatabaseViewerFragmentState();
}

class _DatabaseViewerFragmentState extends State<DatabaseViewerFragment> {
  String _outputText = "กดปุ่มเพื่อดูข้อมูลในฐานข้อมูล";
  bool _isLoading = false;

  Future<void> _showAllData() async {
    setState(() {
      _isLoading = true;
      _outputText = "กำลังดึงข้อมูล...";
    });
    try {
      final roomDB = RoomDB(dbName: "rooms.db");
      final rooms = await roomDB.loadAllData();
      final horPukList = await roomDB.loadAllHorPuk();
      final buffer = StringBuffer();
      buffer.writeln("=== 📋 ข้อมูลห้องทั้งหมด ===");
      if (rooms.isEmpty) {
        buffer.writeln("❌ ไม่มีข้อมูลห้องในฐานข้อมูล");
      } else {
        buffer.writeln("📊 จำนวนห้องทั้งหมด: ${rooms.length} ห้อง\n");
        for (int i = 0; i < rooms.length; i++) {
          final room = rooms[i];
          buffer.writeln("🏠 ห้องที่ ${i + 1}:");
          buffer.writeln("   ชื่อห้อง: ${room.roomName}");
          buffer.writeln("   ราคา/เดือน: ${room.monthlyPrice} บาท");
          buffer.writeln("   สถานะ: ${_getStatusText(room.roomStatus)}");
          buffer.writeln("   วันที่สร้าง: ${room.timeStamp}");
          buffer.writeln("   ──────────────────────────────");
        }
      }
      buffer.writeln("\n=== 🏢 ข้อมูลหอพักทั้งหมด ===");
      if (horPukList.isEmpty) {
        buffer.writeln("❌ ไม่มีข้อมูลหอพักในฐานข้อมูล");
      } else {
        buffer.writeln("📊 จำนวนหอพักทั้งหมด: ${horPukList.length} หอพัก\n");
        for (int i = 0; i < horPukList.length; i++) {
          final horPuk = horPukList[i];
          buffer.writeln("🏢 หอพักที่ ${i + 1}: ${horPuk.horPukName}");
          buffer.writeln("   จำนวนแถว: ${horPuk.rows.length} แถว");
          int totalFloors = 0;
          int totalRooms = 0;
          for (int j = 0; j < horPuk.rows.length; j++) {
            final row = horPuk.rows[j];
            buffer.writeln("   └─ แถวที่ ${j + 1}: ${row.rowName}");
            buffer.writeln("      จำนวนชั้น: ${row.floor.length} ชั้น");
            for (int k = 0; k < row.floor.length; k++) {
              final floor = row.floor[k];
              buffer.writeln("      └─ ชั้นที่ ${k + 1}: ${floor.floorName}");
              buffer.writeln("         จำนวนห้อง: ${floor.rooms.length} ห้อง");
              for (int l = 0; l < floor.rooms.length; l++) {
                final room = floor.rooms[l];
                buffer.writeln("         └─ ห้อง ${l + 1}: ${room.roomName}");
                buffer.writeln(
                  "            ราคา/เดือน: ${room.monthlyPrice} บาท",
                );
                buffer.writeln(
                  "            เงินประกัน: ${room.depositPrice} บาท",
                );
                buffer.writeln("            สัญญา: ${room.contract} เดือน");
                buffer.writeln(
                  "            สถานะ: ${_getStatusText(room.paymentStatus)}",
                );
              }
              totalRooms += floor.rooms.length;
            }
            totalFloors += row.floor.length;
          }
          buffer.writeln("   📊 สรุป: ${totalFloors} ชั้น, ${totalRooms} ห้อง");
          buffer.writeln("   ──────────────────────────────");
        }
      }
      setState(() {
        _outputText = buffer.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _outputText = "เกิดข้อผิดพลาด: $e";
        _isLoading = false;
      });
    }
  }

  String _getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.noTenant:
        return "ยังไม่มีผู้เช่า";
      case PaymentStatus.complete:
        return "ชำระเงินแล้ว";
      case PaymentStatus.overDue:
        return "ค้างชำระเกินกำหนด";
      case PaymentStatus.pending:
        return "รอการชำระเงิน";
      default:
        return "ไม่ทราบสถานะ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ดูข้อมูลฐานข้อมูล', style: GoogleFonts.prompt()),
        backgroundColor: const Color.fromARGB(255, 157, 139, 167),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFA695AF), Color(0xff9e8da9)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _showAllData,
                icon: const Icon(Icons.refresh),
                label: Text('โหลดข้อมูล', style: GoogleFonts.prompt()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 96, 90, 138),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 96, 90, 138),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _outputText,
                        style: GoogleFonts.prompt(fontSize: 14, height: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
