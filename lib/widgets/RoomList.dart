import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/provider/roomProvider.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  List<double> roomListHeight = [];
  List<double> roomListBottomRadiusFromShowState = [];

  double roomListWidth = 365;
  Color greyTextColor = const Color(0xFF404040);
  Color mainThemeColor = const Color(0xFF6D669D);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RoomProvider>(context,listen: false).initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final roomProvider = Provider.of<RoomProvider>(context);
    final length = roomProvider.roomData.length;

    // ถ้ายังไม่เคย initialize หรือจำนวนห้องเปลี่ยน
    if (roomListHeight.length != length) {
      roomListHeight = List.generate(length, (_) => 0);
      roomListBottomRadiusFromShowState = List.generate(length, (_) => 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, roomProvider, child) {
        return Center(
          child: Container(
            width: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: mainThemeColor, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 365,
                child: roomProvider.roomData.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: roomProvider.roomData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      roomListHeight[index] =
                                          roomListHeight[index] == 0 ? 60 : 0;
                                      roomListBottomRadiusFromShowState[
                                              index] =
                                          roomListBottomRadiusFromShowState[
                                                      index] ==
                                                  0
                                              ? 5
                                              : 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0x336D669D),
                                      borderRadius: BorderRadius.vertical(
                                        top: const Radius.circular(5),
                                        bottom: Radius.circular(
                                          roomListBottomRadiusFromShowState[
                                              index],
                                        ),
                                      ),
                                    ),
                                    width: 365,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ห้อง : ${roomProvider.roomData[index].roomName}",
                                            style: GoogleFonts.prompt(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "สถานะการชำระ : ",
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "ราคาต่อเดือน : ${roomProvider.roomData[index].monthlyPrice}",
                                              style: GoogleFonts.prompt(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "ระยะสัญญา : ",
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
                            fontSize: 18,
                            color: greyTextColor,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
