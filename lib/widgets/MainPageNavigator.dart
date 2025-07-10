import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/fragments/AddHorPuk.dart';
import 'package:roomality/fragments/AddRoom.dart';

class MainFrameNavigator extends StatefulWidget {
  const MainFrameNavigator({super.key});

  @override
  State<MainFrameNavigator> createState() => _MainFrameNavigatorState();
}

class _MainFrameNavigatorState extends State<MainFrameNavigator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 370,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          
        ),
        child: Row( // Add Room
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),

             child: Column(
               children: [
                 InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const AddRoomFragment()));
                  },
                   child: Container( // Add Room
                     width: 60,
                     height: 60,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(100)),
                       color: Color(0x556D669D)
                     ),
                   ),
                 ),
                 Text("เพิ่มห้องเช่า", style: GoogleFonts.prompt(fontSize: 14),)
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),

             child: Column(
               children: [
                 InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const AddHorPukFragment()));
                  },
                   child: Container( // Add HorPuk
                     width: 60,
                     height: 60,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(100)),
                       color: Color(0x556D669D)
                     ),
                   ),
                 ),
                 Text("เพิ่มหอพัก", style: GoogleFonts.prompt(fontSize: 14),)
               ],
             ),
           ),
         ],
        ),
      ),
    );
  }
}