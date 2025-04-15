import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/fragments/HorPukFragment.dart';

class ShowDetail extends StatefulWidget {
  final int index;
  final int row;
  final int floor;
  final int room;
  const ShowDetail({super.key, required this.index, required this.row, required this.floor, required this.room});

  @override
  State<ShowDetail> createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 96, 90, 138)
        ),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => HorPukFragment(index: widget.index,row: widget.row,floor:widget.floor,room:widget.room)));
        },
        child: Text("ดูข้อมูล", style: GoogleFonts.prompt(fontSize: 16))
        ),
    );
  }
}