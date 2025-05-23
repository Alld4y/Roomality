import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/provider/HorPukProvider.dart';
import 'package:roomality/provider/roomProvider.dart';
import 'package:roomality/widgets/HorPukList.dart';
import 'package:roomality/widgets/MainFrameNavigator.dart';
import 'package:roomality/widgets/RoomList.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  double roomListWidth = 365;



  Color greyTextColor = Color(0xFF404040);
  Color mainThemeColor = Color(0xFF6D669D);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(builder: (context,RoomProvider roomProvider, Widget? child){
       
      return Consumer(builder: (context,HorPukProvider horPukProvider , Widget? child){
          return SingleChildScrollView(
      //physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const RoomalityAppBar(),
            const SizedBox(height: 20),
            MainFrameNavigator(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                "รายการห้องเช่าของฉัน : ${roomProvider.roomData.length} ห้อง",
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
                "รายการหอพักของฉัน : ${horPukProvider.horPukData.length} หอพัก",
                style: GoogleFonts.prompt(
                  textStyle: TextStyle(fontSize: 20, color: greyTextColor),
                ),
              ),
            ),
            HorPukList(),
          ],
        ),
      ),
    );
      });
    });
  }
}
