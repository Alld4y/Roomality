import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/fragments/RoomFragment.dart';

class ShowRoomDetail extends StatefulWidget {
  final int index;
  const ShowRoomDetail({super.key, required this.index});

  @override
  State<ShowRoomDetail> createState() => _ShowRoomDetailState();
}

class _ShowRoomDetailState extends State<ShowRoomDetail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.24,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 96, 90, 138)
        ),
        onPressed: () {
         Navigator.push(context,MaterialPageRoute(builder: (context) => RoomFragment(index: widget.index)));
        },
        child: Text("ดูข้อมูล", style: GoogleFonts.prompt(fontSize: 16))
        ),
    );
  }
}