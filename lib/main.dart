import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/database/room_db.dart';
import 'package:roomality/fragments/Login.dart';
import 'package:roomality/fragments/Register.dart';
import 'package:roomality/provider/HorPukProvider.dart';
import 'package:roomality/provider/roomProvider.dart';
import 'package:roomality/widgets/mainPage.dart';

void main() async {
  runApp(Home());
  // await RoomDB(dbName: "rooms.db").deleteStore("rooms"); // rooms / horPuk
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RoomProvider()),
        ChangeNotifierProvider(create: (context) => HorPukProvider()),
      ],
      child: MaterialApp(
        title: "Roomality",
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     "Roomality",
          //     style: GoogleFonts.prompt(
          //       fontSize: 20,
          //       color: Color.fromARGB(255, 66, 62, 95),
          //     ),
          //   ),
          //   // logo image
          //   // leading: Padding(
          //   //   padding: const EdgeInsets.all(8.0),
          //   //   child: Image.asset(
          //   //   'assets/images/roomality.png',
          //   //   fit: BoxFit.cover,
          //   //   ),
          //   // ),
          //   backgroundColor: Color(0xFFA695AF),
          //   //backgroundColor: Color(0xFFFFFFFF),
          //   centerTitle: true,
          //   elevation: 0,
          //   scrolledUnderElevation: 0,
          // ),
          body: LoginPage(),
        ),
      ),
    );
  }
}
