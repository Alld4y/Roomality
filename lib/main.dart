import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/widgets/mainFrame.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

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
          body: MainPage()
      ),
    );
  }
}
