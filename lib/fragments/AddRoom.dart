import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRoomFragment extends StatefulWidget {
  const AddRoomFragment({super.key});

  @override
  State<AddRoomFragment> createState() => _AddRoomFragmentState();
}

class _AddRoomFragmentState extends State<AddRoomFragment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roomality",
      home: Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มข้อมูลห้องเช่า", style: GoogleFonts.prompt(fontSize: 20, color: Color.fromARGB(255, 66, 62, 95))),
          // logo image
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
            'assets/images/roomality.png',
            fit: BoxFit.cover,
            ),
          ),
          backgroundColor: Color(0xFFA695AF),
          //backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
          body: AddRoom()
      ),
    );
  }
}

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0))
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "",
              filled: true,
              fillColor: Color(0x33A695AF),
              border: OutlineInputBorder(
                borderRadius: 
                BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide.none
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(child: ElevatedButton(onPressed: () {}, child: Text("ยืนยัน")))
      ],
    );
  }
}