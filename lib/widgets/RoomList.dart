import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/models/room.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  List<double> roomListHeight = List.generate(roomData.length, (index) => 0);
  double roomListWidth = 365;
  List<double> roomListBottomRadiusFromShowState = List.generate(
    roomData.length,
    (index) => 5,
  );
  Color greyTextColor = Color(0xFF404040);
  Color mainThemeColor = Color(0xFF6D669D);
  double roomRentalContainerHeight =
      roomData.isEmpty ? 67 : roomData.length * 42 + 25;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: roomRentalContainerHeight,
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mainThemeColor, width: 2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: SizedBox(
              width: 365,
              height:
                  (roomData.isEmpty ? 67 : roomData.length * 42 + 25) +
                  roomListHeight.fold(0, (prev, element) => prev + element) -
                  5,
              child:
                  roomData.isNotEmpty
                      ? ListView.builder(
                        itemCount: roomData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print(horPukData[0].rooms.length);
                                    setState(() {
                                      roomListHeight[index] =
                                          roomListHeight[index] == 0 ? 60 : 0;
                                      roomListBottomRadiusFromShowState[index] =
                                          roomListBottomRadiusFromShowState[index] ==
                                                  0
                                              ? 5
                                              : 0;
                                      roomRentalContainerHeight =
                                          (roomData.isEmpty
                                              ? 67
                                              : roomData.length * 42 + 25) +
                                          roomListHeight.fold(
                                            0,
                                            (prev, element) => prev + element,
                                          );
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x336D669D),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(5),
                                        bottom: Radius.circular(
                                          roomListBottomRadiusFromShowState[index],
                                        ),
                                      ),
                                      //border: Border.all(color: Color(0xFF6D669D))
                                    ),
                                    width: 365,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ห้อง : ${roomData[index].roomName}",
                                            style: GoogleFonts.prompt(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "สถานะการชำระ : ${roomData[index].paymentState}",
                                            style: GoogleFonts.prompt(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastEaseInToSlowEaseOut,
                                child: Container(
                                  width: roomListWidth,
                                  height: roomListHeight[index],
                                  decoration: const BoxDecoration(
                                    color: Color(0x116D669D),
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      10,
                                      4,
                                      10,
                                      4,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "ราคาต่อเดือน : ${roomData[index].monthlyPrice}",
                                              style: GoogleFonts.prompt(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "ระยะสัญญา : ${roomData[index].contract}",
                                              style: GoogleFonts.prompt(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                      : Center(
                        child: Text(
                          "ไม่มีข้อมูลห้องเช่า",
                          style: GoogleFonts.prompt(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: greyTextColor,
                            ),
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
