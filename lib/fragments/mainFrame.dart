import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/models/room.dart';
import 'package:roomality/widgets/HorPukList.dart';
import 'package:roomality/widgets/RoomList.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  List<double> roomListHeight = List.generate(roomData.length, (index) => 0);
  double roomListWidth = 365;
  List <double> roomListBottomRadiusFromShowState = List.generate(roomData.length, (index)=> 5);
  Color greyTextColor = Color(0xFF404040);
  Color mainThemeColor = Color(0xFF6D669D);
  double roomRentalContainerHeight = roomData.isEmpty ? 67 : roomData.length*42 + 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
            "รายการห้องเช่าของฉัน : ${roomData.length} ห้อง",
            style: GoogleFonts.prompt(
              textStyle: TextStyle(fontSize: 20, color: greyTextColor),
            ),
          ),
        ),
        RoomList(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
            "รายการหอพักของฉัน : ${horPukData.length} หอพัก",
            style: GoogleFonts.prompt(
              textStyle: TextStyle(fontSize: 20, color: greyTextColor),
            ),
          ),
        ),
        HorPukList(),
      ],
    );
  }
}
