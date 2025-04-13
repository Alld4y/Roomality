import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/models/room.dart';

class HorPukList extends StatefulWidget {
  const HorPukList({super.key});

  @override
  State<HorPukList> createState() => _HorPukListState();
}

class _HorPukListState extends State<HorPukList> {
  double horPukContainerHeight = 300;
  double horPukListBottomRadiusFromShowState = 5;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: horPukContainerHeight,
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF6D669D), width: 2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              child: ListView.builder(
                itemCount: horPukData.length,
                itemBuilder: (context, index) {
                  return Column(
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Column(
                            children: [
                              Container(
                                width: 370,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0x336D669D),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(5),
                                    bottom: Radius.circular(horPukListBottomRadiusFromShowState),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("หอพัก ${horPukData[index].horPukName}", style: GoogleFonts.prompt(fontSize: 18),),
                                      Text("จำนวนห้องพัก : ${horPukData[index].rooms.length}", style: GoogleFonts.prompt(fontSize:18))
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedSize(
                                curve: Curves.fastOutSlowIn,
                                duration: Duration(milliseconds: 500),
                                child: Container(
                                  width: 360,
                                  height: 67,
                                  decoration: BoxDecoration(
                                    color: Color(0x116D669D),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(0),
                                      bottom: Radius.circular(5),
                                    ),
                                  ),
                                  child: Column(
                                    children: [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
