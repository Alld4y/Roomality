
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/provider/HorPukProvider.dart';
import 'package:roomality/widgets/showDetail.dart';

class HorPukList extends StatefulWidget {
  const HorPukList({super.key});

  @override
  State<HorPukList> createState() => _HorPukListState();
}

class _HorPukListState extends State<HorPukList> {
  List<double> bottomRowRadius = [];
  List<double> horPukFloorHeight = [];
  double horPukListBottomRadiusFromShowState = 5;
  double horPukRowWidth = 335;
  List<double> horPukRowHeight = [];
  List<double> topRowRadius = [];
  List<double> horPukRoomHeight = [];

  List<Map<String, int>> rowRoomIndexRanges = [];
  List<Map<String, int>> rowRowIndexRanges = [];
  List<List<bool>> isExpandedList = [];
  List<List<bool>> isExpandedListFloor = [];
  List<List<bool>> isExpandedListRow = [];

  List<List<List<bool>>> isExpandedRow = [];
  List<List<List<List<bool>>>> isExpandedFloor = [];

  List isRowTopRadius = [];
  List isRowBottomRadius = [];
  List isFloorTopRadius = [];
  List isFloorBottomRadius = [];
  List isRoomTopRadius = [];
  List isRoomBottomRadius = [];

  List firstIsRowTopRadius = [];
  List firstIsRowBottomRadius = [];
  List firstIsFloorTopRadius = [];
  List firstIsFloorBottomRadius = [];
  List firstIsRoomTopRadius = [];
  List firstIsRoomBottomRadius = [];
  int currentIndex = 0;
  int currentRowIndex = 0;

  int radiusInitState = 0;

  int renderHack = 0;

  bool have1RowInHorPuk = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Provider.of<HorPukProvider>(context,listen: false).initHorPukData();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HorPukProvider horPukProvider, Widget? child) {
        for(int count = 0 ; count < horPukProvider.horPukData.length ; count++){
          if(horPukProvider.horPukData[count].rows.length == 1){
            print("Have 1 Row In HorPuk");
            have1RowInHorPuk = true;
          }else{
            have1RowInHorPuk = false;
          }
        }
        // horPukProvider.initHorPukData();
        if(radiusInitState < horPukProvider.horPukData.length){
        print("horPukProvider = $horPukProvider");
            bottomRowRadius = List.generate(
    horPukProvider.horPukData.expand((horPuk) => horPuk.rows).length,
    (index) {
      if (index == horPukProvider.horPukData.expand((horPuk) => horPuk.rows).length - 1) {
        return 5;
      } else {
        return 0;
      }
    },
  );
  horPukFloorHeight = List.generate(
    horPukProvider.horPukData
        .expand((horPuk) {
          return horPuk.rows;
        })
        .expand((row) => row.floor)
        .length,
    (index) => 0,
  );
  horPukRowHeight = List.generate(horPukProvider.horPukData.length, (index) => 0);
  topRowRadius = List.generate(
    horPukProvider.horPukData.expand((horPuk) {
      return horPuk.rows;
    }).length,
    (index) => 0,
  );
  horPukRoomHeight = List.generate(
    horPukProvider.horPukData
        .expand((horPuk) => horPuk.rows)
        .expand((row) => row.floor)
        .expand((floor) => floor.rooms)
        .length,
    (index) => 0,
  );

    for (var horPuk in horPukProvider.horPukData) {
      int rowCount = horPuk.rows.length;
      if (currentRowIndex < currentRowIndex + rowCount - 1) {
        rowRowIndexRanges.add({
          'start': currentRowIndex,
          'end': currentRowIndex + rowCount - 1,
        });
        currentRowIndex += rowCount;

        //print(rowRowIndexRanges);
        //initialState = true;
      }
    }

    for (int i = 0; i < horPukProvider.horPukData.length; i++) {
      isExpandedRow.add([]);
      isExpandedFloor.add([]);
      isRowTopRadius.add([]);
      isRowBottomRadius.add([]);
      isFloorTopRadius.add([]);
      isFloorBottomRadius.add([]);
      isRoomTopRadius.add([]);
      isRoomBottomRadius.add([]);
      for (int j = 0; j < horPukProvider.horPukData[i].rows.length; j++) {
        //horPuk
        isExpandedRow[i].add([]);
        isExpandedFloor[i].add([]);
        isRowBottomRadius[i].add(false);
        isRowTopRadius[i].add(false);
        isFloorTopRadius[i].add([]);
        isFloorBottomRadius[i].add([]);
        isRoomTopRadius[i].add([]);
        isRoomBottomRadius[i].add([]);
        if (j == horPukProvider.horPukData[i].rows.length - 1) {
          isRowBottomRadius[i][j] = true;
        } else {
          isRowBottomRadius[i][j] = false;
        }
        for (
          int k = 0;
          k < horPukProvider.horPukData[i].rows[j].floor.length;
          k++
        ) {
          isRoomTopRadius[i][j].add([]);
          isRoomBottomRadius[i][j].add([]);
          isFloorTopRadius[i][j].add(false);
          isFloorBottomRadius[i][j].add(false);
          if (k == horPukProvider.horPukData[i].rows[j].floor.length - 1) {
            isFloorBottomRadius[i][j][k] = true;
          }
          isExpandedRow[i][j].add(false);
          isExpandedFloor[i][j].add([]);
          for (
            int l = 0;
            l < horPukProvider.horPukData[i].rows[j].floor[k].rooms.length;
            l++
          ) {
            isRoomTopRadius[i][j][k].add(false);
            if (l !=
                horPukProvider.horPukData[i].rows[j].floor[k].rooms.length -
                    1) {
              isRoomBottomRadius[i][j][k].add(false);
            } else {
              isRoomBottomRadius[i][j][k].add(true);
            }
            isExpandedFloor[i][j][k].add(false);
          }
        }
      }
      print("+++++++++++++ isRoomBottomRadius = $isRoomBottomRadius ++++++++++++++");
    }

    for (var horPuk in horPukProvider.horPukData) {
      isExpandedListRow.add(List.filled(horPuk.rows.length, false));
      for (var row in horPuk.rows) {
        isExpandedListFloor.add(List.filled(row.floor.length, false));
        for (var floor in row.floor) {
          isExpandedList.add(List.filled(floor.rooms.length, false));
        }
      }
    }
    print("isExpandedRow = $isExpandedRow");
    print(isExpandedListFloor);
    print(isExpandedListRow);

    for (int i = 0; i < horPukProvider.horPukData.length; i++) {
      for (int j = 0; j < horPukProvider.horPukData[i].rows.length; j++) {
        for (
          int k = 0;
          k < horPukProvider.horPukData[i].rows[j].floor.length;
          k++
        ) {
          int roomCount =
              horPukProvider.horPukData[i].rows[j].floor[k].rooms.length;
          if (currentIndex <= currentIndex + roomCount - 1) {
            rowRoomIndexRanges.add({
              'start': currentIndex,
              'end': currentIndex + roomCount - 1,
            });
            currentIndex += roomCount;
            print("rowRoomIndexRanges = $rowRoomIndexRanges");
          }
        }
        //   int roomCount = horPukData[i].row[j].floor.length;
        //   if(currentIndex <= currentIndex + roomCount - 1){
        //     rowRoomIndexRanges.add({
        //     'start': currentIndex,
        //     'end': currentIndex + roomCount - 1,
        //   });
        //   currentIndex += roomCount;
        //   print(rowRoomIndexRanges);
        // }
      }
    }
    radiusInitState = radiusInitState+1;
         }
    
        return Center(
          child: Container(
            width: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF6D669D), width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: horPukProvider.horPukData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    for (
                                      int row = 0;
                                      row <
                                          horPukProvider
                                              .horPukData[index]
                                              .rows
                                              .length;
                                      row++
                                    ) {
                                      for (
                                        int floor = 0;
                                        floor <
                                            isExpandedRow[index][row].length;
                                        floor++
                                      ) {
                                        for (
                                          int room = 0;
                                          room <
                                              isExpandedFloor[index][row][floor]
                                                  .length;
                                          room++
                                        ) {
                                          isExpandedFloor[index][row][floor][room] =
                                              false;
                                        }
                                      }
                                    }

                                    for (
                                      var i = 0;
                                      i < horPukProvider.horPukData.length;
                                      i++
                                    ) {
                                      for (
                                        var j = 0;
                                        j <
                                            horPukProvider
                                                .horPukData[i]
                                                .rows
                                                .length;
                                        j++
                                      ) {
                                        for (
                                          var k = 0;
                                          k <
                                              horPukProvider
                                                  .horPukData[i]
                                                  .rows[j]
                                                  .floor
                                                  .length;
                                          k++
                                        ) {
                                          if(index < isExpandedRow.length && j < isExpandedRow[index].length){
                                            if (isExpandedRow[index].isNotEmpty && isExpandedRow[index][j].isNotEmpty) {
                                          isExpandedRow[index][j][0] = false;
                                          }
                                          }
                                        }
                                      }
                                    }
                                    print("isExpandedFloor = $isExpandedFloor");
                                    isExpandedListRow[index][0] =
                                        isExpandedListRow[index][0] == false
                                            ? true
                                            : false;
                                    horPukRowHeight[index] =
                                        horPukRowHeight[index] == 0 ? 40 : 0;
                                    if (horPukRowHeight[index] == 0) {
                                      // close

                                      
                                        for (
                                          int j = 0;
                                          j <
                                              horPukProvider
                                                  .horPukData[index]
                                                  .rows
                                                  .length;
                                          j++
                                        ) {
                                          isRowTopRadius[index][j] = false;
                                          if (j !=
                                              horPukProvider
                                                      .horPukData[index]
                                                      .rows
                                                      .length -
                                                  1) {
                                            isRowBottomRadius[index][j] = false;
                                          }
                                          for (
                                            int k = 0;
                                            k <
                                                horPukProvider
                                                    .horPukData[index]
                                                    .rows[j]
                                                    .floor
                                                    .length;
                                            k++
                                          ) {
                                            isFloorTopRadius[index][j][k] = false;
                                            if (k !=
                                                horPukProvider
                                                        .horPukData[index]
                                                        .rows[j]
                                                        .floor
                                                        .length -
                                                    1) {
                                              isFloorBottomRadius[index][j][k] =
                                                  false;
                                            }
                                          }
                                        
                                      }

                                      print("this   $isRowBottomRadius");
                                      print(" this   $isRowTopRadius");

                                      // isRowTopRadius = firstIsRowTopRadius;
                                      // isRowBottomRadius = firstIsRowBottomRadius;

                                      horPukRoomHeight.fillRange(
                                        0,
                                        horPukRoomHeight.length,
                                        horPukRoomHeight.fold(
                                          0.0,
                                          (prev, element) => 0,
                                        ),
                                      );
                                      horPukFloorHeight.fillRange(
                                        0,
                                        horPukFloorHeight.length,
                                        horPukFloorHeight.fold(
                                          0.0,
                                          (prev, element) => 0,
                                        ),
                                      );
                                      topRowRadius.fillRange(
                                        0,
                                        topRowRadius.length,
                                        0,
                                      );
                                      for (
                                        int i = 0;
                                        i < bottomRowRadius.length;
                                        i++
                                      ) {
                                        if (i == bottomRowRadius.length - 1) {
                                          bottomRowRadius[i] = 5;
                                        } else {
                                          bottomRowRadius[i] = 0;
                                        }
                                      }
                                    }
                                    horPukListBottomRadiusFromShowState =
                                        horPukListBottomRadiusFromShowState == 5
                                            ? 0
                                            : 5;
                                  });
                                  
                                  if(have1RowInHorPuk){
                                    setState(() {
                                                for(int row = 0 ; row < horPukProvider.horPukData[index].rows.length ; row++){
                                                  isExpandedRow[index][row][0] = false;
                                                               print("isExpandedRow = $isExpandedRow");
                                              print("isRowBottomRadius = $isRowBottomRadius");

                                                }
                                              });

                                                // แล้วค่อย update อย่างอื่นในรอบถัดไป
                                                  Future.delayed(Duration(milliseconds: 10), () {
                                               for(int row = 0 ; row < horPukProvider.horPukData[index].rows.length ; row++){

                                                setState(() {
                                                  if(renderHack==0){
                                                    if (!(horPukProvider.horPukData[index].rows.length - 1 == row)) {
                                                    isRowBottomRadius[index][row] = true;
                                                  }
                                                  isRowTopRadius[index][row + 1] = false;
                                                  }


                                                  // if (horPukProvider.horPukData[index].rows[row].floor.length == 1) {
                                                  //   isExpandedFloor[index][row][0][0] =
                                                  //       !isExpandedFloor[index][row][0][0];
                                                  // } else {
                                                  //   for (int floor = 0;
                                                  //       floor < horPukProvider.horPukData[index].rows[row].floor.length;
                                                  //       floor++) {
                                                  //     isExpandedFloor[index][row][floor][0] = false;
                                                  //   }
                                                  // }
                                                                 print("isExpandedRow = $isExpandedRow");
                                              print("isRowBottomRadius = $isRowBottomRadius");

                                                });
                                                  }
                                                  setState(() {
                                                    renderHack = renderHack+1;
                                                  });
                                              });
                                               
                                  }
                                              
                                },
                                child: Container(
                                  width: 370,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0x556D669D),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(
                                        horPukListBottomRadiusFromShowState,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "หอพัก ${horPukProvider.horPukData[index].horPukName}",
                                          style: GoogleFonts.prompt(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "จำนวนห้องพัก : ${(horPukProvider.horPukData[index].rows.fold(0, (prev, element) => prev + element.floor.fold(0, (prev, element) => element.rooms.length + prev)))} ห้อง",
                                          style: GoogleFonts.prompt(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    horPukProvider.horPukData[index].rows.length,
                                itemBuilder:
                                    (context, row) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        12,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print("กด index: $index row: $row");
                                              print("isExpandedRow = $isExpandedRow");
                                              print("isRowBottomRadius = $isRowBottomRadius");

                                              // แก้เฉพาะ isExpandedRow ก่อน
                                              setState(() {
                                                isExpandedRow[index][row][0] = !isExpandedRow[index][row][0];
                                                               print("isExpandedRow = $isExpandedRow");
                                              print("isRowBottomRadius = $isRowBottomRadius");

                                              });

                                              // แล้วค่อย update อย่างอื่นในรอบถัดไป
                                              Future.delayed(Duration(milliseconds: 10), () {
                                                setState(() {
                                                  if (!(horPukProvider.horPukData[index].rows.length - 1 == row)) {
                                                    isRowBottomRadius[index][row] = !isRowBottomRadius[index][row];
                                                    isRowTopRadius[index][row + 1] = !isRowTopRadius[index][row + 1];
                                                  }

                                                  if (horPukProvider.horPukData[index].rows[row].floor.length == 1) {
                                                    isExpandedFloor[index][row][0][0] =
                                                        !isExpandedFloor[index][row][0][0];
                                                  } else {
                                                    for (int floor = 0;
                                                        floor < horPukProvider.horPukData[index].rows[row].floor.length;
                                                        floor++) {
                                                      isExpandedFloor[index][row][floor][0] = false;
                                                    }
                                                  }
                                                                 print("isExpandedRow = $isExpandedRow");
                                              print("isRowBottomRadius = $isRowBottomRadius");

                                                });
                                              });
                                            },
                                            child: AnimatedSize(
                                              duration: Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                height:
                                                    isExpandedListRow[index][0] ==
                                                            true
                                                        ? 40
                                                        : 0,
                                                width: horPukRowWidth,
                                                decoration: BoxDecoration(
                                                  color: Color(0x336D669D),
                                                  borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(
                                                      isRowTopRadius[index][row] ==
                                                              true
                                                          ? 5
                                                          : 0,
                                                    ),
                                                    bottom: Radius.circular(
                                                      isRowBottomRadius[index][row] ==
                                                              true
                                                          ? 5
                                                          : 0,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: Text(
                                                    // แถวที่
                                                    horPukProvider
                                                        .horPukData[index]
                                                        .rows[row]
                                                        .rowName,
                                                    style: GoogleFonts.prompt(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          AnimatedSize(
                                            curve: Curves.fastOutSlowIn,
                                            duration: Duration(
                                              milliseconds: 500,
                                            ),
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  horPukProvider
                                                      .horPukData[index]
                                                      .rows[row]
                                                      .floor
                                                      .length,
                                              itemBuilder: (context, floor) {
                                                if (horPukProvider
                                                        .horPukData[index]
                                                        .rows[row]
                                                        .floor
                                                        .length ==
                                                    1) {
                                                  return AnimatedSize(
                                                    // หอพักมีชั้นเดียว
                                                    duration: Duration(
                                                      milliseconds: 500,
                                                    ),
                                                    curve: Curves.fastOutSlowIn,
                                                    child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          horPukProvider
                                                              .horPukData[index]
                                                              .rows[row]
                                                              .floor[0]
                                                              .rooms
                                                              .length,
                                                      itemBuilder: (
                                                        context,
                                                        room,
                                                      ) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 16,
                                                              ),
                                                          child: Container(
                                                            height:
                                                                isExpandedFloor[index][row][0][0] ==
                                                                        true
                                                                    ? 40
                                                                    : 0,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.vertical(
                                                                bottom: Radius.circular(
                                                                  isRoomBottomRadius[index][row][0][room] ==
                                                                          true
                                                                      ? 5
                                                                      : 0,
                                                                ),
                                                              ),
                                                              color: Color(
                                                                0x116D669D,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    8.0,
                                                                  ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "ห้อง ${horPukProvider.horPukData[index].rows[row].floor[floor].rooms[room].roomName}",
                                                                    style: GoogleFonts.prompt(
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "สถานะ : ",
                                                                        style: GoogleFonts.prompt(
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        (horPukProvider
                                                                            .horPukData[index]
                                                                            .rows[row]
                                                                            .floor[floor]
                                                                            .rooms[room]
                                                                            .paymentStatus
                                                                            .icon),
                                                                        color:
                                                                            horPukProvider.horPukData[index].rows[row].floor[floor].rooms[room].paymentStatus.iconColor,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  ShowDetail(
                                                                    index:
                                                                        index,
                                                                    row: row,
                                                                    floor:
                                                                        floor,
                                                                    room: room,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 16,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (horPukProvider
                                                                          .horPukData[index]
                                                                          .rows[row]
                                                                          .floor
                                                                          .length -
                                                                      1 !=
                                                                  floor) {
                                                                isFloorTopRadius[index][row][floor +
                                                                        1] =
                                                                    !isFloorTopRadius[index][row][floor +
                                                                        1];
                                                                isFloorBottomRadius[index][row][floor] =
                                                                    !isFloorBottomRadius[index][row][floor];
                                                              }
                                                              isExpandedFloor[index][row][floor][0] =
                                                                  !isExpandedFloor[index][row][floor][0];
                                                            });
                                                          },
                                                          child: Container(
                                                            height:
                                                                isExpandedRow[index][row][0] ==
                                                                        true
                                                                    ? 40
                                                                    : 0,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.vertical(
                                                                top: Radius.circular(
                                                                  isFloorTopRadius[index][row][floor] ==
                                                                          true
                                                                      ? 5
                                                                      : 0,
                                                                ),
                                                                bottom: Radius.circular(
                                                                  isFloorBottomRadius[index][row][floor] ==
                                                                          true
                                                                      ? 5
                                                                      : 0,
                                                                ),
                                                              ),
                                                              color: Color(
                                                                0x226D669D,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    8.0,
                                                                  ),
                                                              child: Text(
                                                                // ชั้นที่
                                                                horPukProvider
                                                                    .horPukData[index]
                                                                    .rows[row]
                                                                    .floor[floor]
                                                                    .floorName,
                                                                style:
                                                                    GoogleFonts.prompt(
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        AnimatedSize(
                                                          duration: Duration(
                                                            milliseconds: 500,
                                                          ),
                                                          curve:
                                                              Curves
                                                                  .fastOutSlowIn,
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                horPukProvider
                                                                    .horPukData[index]
                                                                    .rows[row]
                                                                    .floor[floor]
                                                                    .rooms
                                                                    .length,
                                                            itemBuilder: (
                                                              context,
                                                              room,
                                                            ) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 16,
                                                                    ),
                                                                child: Container(
                                                                  height:
                                                                      isExpandedFloor[index][row][floor][0] ==
                                                                              true
                                                                          ? 40
                                                                          : 0,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.vertical(
                                                                      top: Radius.circular(
                                                                        isRoomTopRadius[index][row][floor][room] ==
                                                                                true
                                                                            ? 5
                                                                            : 0,
                                                                      ),
                                                                      bottom: Radius.circular(
                                                                        isRoomBottomRadius[index][row][floor][room] ==
                                                                                true
                                                                            ? 5
                                                                            : 0,
                                                                      ),
                                                                    ),
                                                                    color: Color(
                                                                      0x116D669D,
                                                                    ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                          8.0,
                                                                        ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "ห้อง ${horPukProvider.horPukData[index].rows[row].floor[floor].rooms[room].roomName}",
                                                                          style: GoogleFonts.prompt(
                                                                            fontSize:
                                                                                17,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "สถานะ : ",
                                                                              style: GoogleFonts.prompt(
                                                                                fontSize:
                                                                                    16,
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              (horPukProvider.horPukData[index].rows[row].floor[floor].rooms[room].paymentStatus.icon),
                                                                              color:
                                                                                  horPukProvider.horPukData[index].rows[row].floor[floor].rooms[room].paymentStatus.iconColor,
                                                                              size:
                                                                                  24,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        ShowDetail(
                                                                          index:
                                                                              index,
                                                                          row:
                                                                              row,
                                                                          floor:
                                                                              floor,
                                                                          room:
                                                                              room,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
