import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/widgets/HorPukRoom.dart';

class HorPukFragment extends StatefulWidget {
  final int index;
  final int row;
  final int floor;
  final int room;
  const HorPukFragment({super.key, required this.index, required this.row, required this.floor, required this.room});

  @override
  State<HorPukFragment> createState() => _HorPukFragmentState();
}

class _HorPukFragmentState extends State<HorPukFragment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roomality",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Roomality", style: GoogleFonts.prompt(fontSize: 20,color: Color.fromARGB(255, 66, 62, 95))),
          // logo image
          // leading: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.asset(
          //   'assets/images/roomality.png',
          //   fit: BoxFit.cover,
          //   ),
          // ),
          backgroundColor: Color(0xFFA695AF),
          //backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
          body: HorPukRoom(index: widget.index,row: widget.row,floor:widget.floor,room:widget.room)
      ),
    );
  }
}