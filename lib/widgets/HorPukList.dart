import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/models/room.dart';
import 'package:roomality/widgets/showDetail.dart';

class HorPukList extends StatefulWidget {
  const HorPukList({super.key});

  @override
  State<HorPukList> createState() => _HorPukListState();
}

class _HorPukListState extends State<HorPukList> {

  List<double> bottomRowRadius = List.generate(horPukData.expand((horPuk)=>horPuk.row).length, (index){
    if(index == horPukData.expand((horPuk)=>horPuk.row).length-1){
      return 5;
    }else{
      return 0;
    }
  });
  List<double> horPukFloorHeight = List.generate(
    horPukData.expand((horPuk) {
     return horPuk.row;
    }).expand((row) => row.floor).length,
    (index) => 0,
  );
  double horPukListBottomRadiusFromShowState = 5;
  double horPukRowWidth = 335;
  List<double> horPukRowHeight = List.generate(
    horPukData.length,
    (index) => 0,
  );
  List<double> topRowRadius = List.generate(horPukData.expand((horPuk){
    return horPuk.row;
  }).length, (index) => 0);
List<double> horPukRoomHeight = List.generate(
  horPukData.expand((horPuk) => horPuk.row)    
    .expand((row) => row.floor)
    .expand((floor) => floor.rooms)
    .length,
  (index) => 0,
);
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



@override
void initState() {
  super.initState();
  int currentIndex = 0;
  int currentRowIndex = 0;
  for (var horPuk in horPukData) {
    int rowCount = horPuk.row.length;
    if(currentRowIndex < currentRowIndex + rowCount - 1){
      rowRowIndexRanges.add({
      'start': currentRowIndex,
      'end': currentRowIndex + rowCount - 1,
    });
    currentRowIndex += rowCount;
     
    //print(rowRowIndexRanges);
    }
  }

  

  for(int i = 0 ; i < horPukData.length ; i++){
    isExpandedRow.add([]);
    isExpandedFloor.add([]);
    isRowTopRadius.add([]);
    isRowBottomRadius.add([]);
    isFloorTopRadius.add([]);
    isFloorBottomRadius.add([]);
    isRoomTopRadius.add([]);
    isRoomBottomRadius.add([]);
    for(int j = 0 ; j < horPukData[i].row.length ; j++){
        //horPuk
        isExpandedRow[i].add([]);
        isExpandedFloor[i].add([]);
        isRowBottomRadius[i].add(false);
        isRowTopRadius[i].add(false);
        isFloorTopRadius[i].add([]);
        isFloorBottomRadius[i].add([]);
        isRoomTopRadius[i].add([]);
        isRoomBottomRadius[i].add([]);
        if(j == horPukData[i].row.length - 1){
          isRowBottomRadius[i][j] = true;
        }else{
          isRowBottomRadius[i][j] = false;
        }
        for(int k = 0 ; k < horPukData[i].row[j].floor.length ; k++){
          isRoomTopRadius[i][j].add([]);
          isRoomBottomRadius[i][j].add([]);
          isFloorTopRadius[i][j].add(false);
          isFloorBottomRadius[i][j].add(false);
          if(k == horPukData[i].row[j].floor.length - 1){
            isFloorBottomRadius[i][j][k] = true;
          }
          isExpandedRow[i][j].add(false);
          isExpandedFloor[i][j].add([]);
          for(int l = 0 ; l < horPukData[i].row[j].floor[k].rooms.length ; l++){
            isRoomTopRadius[i][j][k].add(false);
            if(l != horPukData[i].row[j].floor[k].rooms.length - 1)
            {
              isRoomBottomRadius[i][j][k].add(false);
            }else{
              isRoomBottomRadius[i][j][k].add(true);
            }
            isExpandedFloor[i][j][k].add(false);
          }
        }
      }
      print("+++++++++++++ ${isRoomBottomRadius} ++++++++++++++");
     
    }


   for (var horPuk in horPukData) {
     isExpandedListRow.add(List.filled(horPuk.row.length, false));
    for (var row in horPuk.row) {
        isExpandedListFloor.add(List.filled(row.floor.length, false));
      for (var floor in row.floor) {
        isExpandedList.add(List.filled(floor.rooms.length, false));
      }
    }
  }
      print(isExpandedList);
      print(isExpandedListFloor);
      print(isExpandedListRow);

  for( int i = 0 ; i < horPukData.length ; i++){
    for(int j = 0 ; j < horPukData[i].row.length ; j++){
      for(int k = 0 ; k < horPukData[i].row[j].floor.length ; k++){
        int roomCount = horPukData[i].row[j].floor[k].rooms.length;
        if(currentIndex <= currentIndex + roomCount - 1){
          rowRoomIndexRanges.add({
          'start': currentIndex,
          'end': currentIndex + roomCount - 1,
        });
        currentIndex += roomCount;
        print(rowRoomIndexRanges);
      }}
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

}
  @override
  Widget build(BuildContext context) {
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
              itemCount: horPukData.length,
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

                                  

                                              for(int row = 0 ; row < horPukData[index].row.length ; row ++){
                                                for(int floor = 0 ; floor < isExpandedRow[index][row].length ; floor++){
                                                  for(int room = 0 ; room < isExpandedFloor[index][row][floor].length ; room++){
                                                    isExpandedFloor[index][row][floor][room] = false;
                                                  }
                                                }
                                              }

                                                for (var i = 0; i < horPukData.length; i++) {
                                                  for (var j = 0; j < horPukData[i].row.length; j++) {
                                                    for (var k = 0; k < horPukData[i].row[j].floor.length; k++) {
                                                      isExpandedRow[index][j][0] = false;
                                                    }
                                                  }
                                                }
                                              
                                        print(isExpandedFloor);

                                        

                                isExpandedListRow[index][0] = 
                                    isExpandedListRow[index][0] == false
                                        ? true
                                        : false;
                                
                                horPukRowHeight[index] =
                                    horPukRowHeight[index] == 0 ? 40 : 0;
                                if (horPukRowHeight[index] == 0) {
                                  // close
                                
                                for(int i = 0 ; i < horPukData.length ; i++){
                                  for(int j = 0 ; j < horPukData[i].row.length ; j++){
                                    isRowTopRadius[i][j] = false;
                                    if(j != horPukData[i].row.length - 1){
                                      isRowBottomRadius[i][j] = false;
                                    }
                                    for(int k = 0 ; k < horPukData[i].row[j].floor.length ; k++ ){
                                      isFloorTopRadius[i][j][k] = false;
                                      if(k != horPukData[i].row[j].floor.length - 1){
                                        isFloorBottomRadius[i][j][k] = false;
                                      }
                                    }
                                  }
                                }

                                  print("this   $isRowBottomRadius");
                                  print( " this   $isRowTopRadius");
                                  
                                  // isRowTopRadius = firstIsRowTopRadius;
                                  // isRowBottomRadius = firstIsRowBottomRadius;

                                  horPukRoomHeight.fillRange(0,horPukRoomHeight.length,horPukRoomHeight.fold(0.0,(prev, element) => 0));
                                  horPukFloorHeight.fillRange(0,horPukFloorHeight.length,horPukFloorHeight.fold(0.0,(prev, element) => 0));
                                  topRowRadius.fillRange(0, topRowRadius.length, 0);
                                  for(int i = 0 ; i < bottomRowRadius.length; i++)
                                  {
                                    if(i == bottomRowRadius.length - 1){
                                      bottomRowRadius[i] = 5;
                                    }
                                    else{
                                      bottomRowRadius[i] = 0;
                                    }
                                  }
                                }
                                horPukListBottomRadiusFromShowState =
                                    horPukListBottomRadiusFromShowState == 5
                                        ? 0
                                        : 5;
                              });
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
                                      "หอพัก ${horPukData[index].horPukName}",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                    Text(
                                      "จำนวนห้องพัก : ${(horPukData[index].row.fold(0, (prev, element) => prev + element.floor.fold(0, (prev, element) => element.rooms.length + prev)))} ห้อง",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: horPukData[index].row.length,
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
                                        
                                          setState(() {
                                            print("index: $index row: $row ");
                                            print("rowRoomIndexRanges : ${rowRoomIndexRanges.length}");
                                            print("rowRowIndexRanges : ${rowRoomIndexRanges.length}");
                                            print("horPukFloorHeight : ${horPukFloorHeight.length}");
                                
                                            print("isRowBottomRadius  $isRowBottomRadius");
                                            isExpandedRow[index][row][0] = !isExpandedRow[index][row][0];
                                
                                            // for(int floor = 0 ; floor < isExpandedRow[index][row].length ; floor++){ // Expanded
                                            //   for(int room = 0 ; room < isExpandedFloor[index][row][floor].length ; room++){
                                            //     if(isExpandedRow[index][row][0] == false){
                                            //       isExpandedFloor[index][row][floor][room] = false;
                                            //     }
                                            //   }
                                            // }
                                            
                                            if(!(horPukData[index].row.length - 1 == row)){ // Radius
                                              isRowBottomRadius[index][row] = !isRowBottomRadius[index][row];
                                              isRowTopRadius[index][row+1] = !isRowTopRadius[index][row+1];
                                            }
                                            if(horPukData[index].row[row].floor.length == 1){
                                              //for(int i = 0 ; i < horPukData[index].row[row].floor[0].rooms.length ; i++){
                                                print(isExpandedFloor[index][row][0][0]);
                                                isExpandedFloor[index][row][0][0] = !isExpandedFloor[index][row][0][0];
                                                print(isExpandedFloor[index][row][0][0]);

                                             // }
                                            }
                                          });
                                        },
                                        child: AnimatedSize(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.fastOutSlowIn,
                                          child: Container(
                                            height: isExpandedListRow[index][0] == true ? 40 : 0,
                                            width: horPukRowWidth,
                                            decoration: BoxDecoration(
                                              color: Color(0x336D669D),
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(
                                                  isRowTopRadius[index][row] == true ? 5 : 0,
                                                ),
                                                bottom: Radius.circular(isRowBottomRadius[index][row] == true ? 5 : 0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8,
                                              ),
                                              child: Text(
                                                // แถวที่
                                                horPukData[index]
                                                    .row[row]
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
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              horPukData[index]
                                                  .row[row]
                                                  .floor
                                                  .length,
                                          itemBuilder: (context, floor) {
                                            if (horPukData[index]
                                                    .row[row]
                                                    .floor
                                                    .length ==
                                                1) {
                                              return AnimatedSize( // หอพักมีชั้นเดียว
                                                      duration: Duration(milliseconds:500),
                                                      curve: Curves.fastOutSlowIn,
                                                      child: ListView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: horPukData[index].row[row].floor[0].rooms.length,
                                                        itemBuilder: (context, room) {
                                                          return Padding(
                                                            padding: const EdgeInsets.only(left: 16),
                                                            child: Container(
                                                              height: isExpandedFloor[index][row][0][0] == true ? 40 : 0,
                                                              decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(isRoomBottomRadius[index][row][0][room] == true ? 5 : 0)),
                                                                color: Color(0x116D669D),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("ห้อง ${horPukData[index].row[row].floor[floor].rooms[room].roomName}", style: GoogleFonts.prompt(fontSize:17),),
                                                                    Row(
                                                                      children: [
                                                                        Text("สถานะ : ",style: GoogleFonts.prompt(fontSize: 16)),
                                                                        Icon((horPukData[index].row[row].floor[floor].rooms[room].paymentStatus.icon) , color:  horPukData[index].row[row].floor[floor].rooms[room].paymentStatus.iconColor, size: 24)
                                                                      ],
                                                                    ),
                                                                    ShowDetail(index: index,row: row,floor:floor,room:room),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        )
                                                    );
                                            } else {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                      left: 16,
                                                    ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if(horPukData[index].row[row].floor.length - 1 != floor){
                                                            isFloorTopRadius[index][row][floor+1] = !isFloorTopRadius[index][row][floor+1];
                                                            isFloorBottomRadius[index][row][floor] = !isFloorBottomRadius[index][row][floor];
                                
                                                          }
                                                          isExpandedFloor[index][row][floor][0] = !isExpandedFloor[index][row][floor][0];
                                                        });
                                                      },
                                                      child: Container(
                                                        height:
                                                            isExpandedRow[index][row][0] == true
                                                                ? 40
                                                                : 0,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.vertical(top: Radius.circular(isFloorTopRadius[index][row][floor] == true ? 5 : 0),bottom: Radius.circular(isFloorBottomRadius[index][row][floor] == true ? 5 : 0)),
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
                                                            horPukData[index]
                                                                .row[row]
                                                                .floor[floor]
                                                                .floorName,
                                                            style:
                                                                GoogleFonts.prompt(
                                                                  fontSize: 17,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    AnimatedSize(
                                                      duration: Duration(milliseconds: 500),
                                                      curve: Curves.fastOutSlowIn,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: horPukData[index].row[row].floor[floor].rooms.length,
                                                        itemBuilder: (context, room){
                                                          return Padding(
                                                            padding: const EdgeInsets.only(left: 16),
                                                            child: Container(
                                                              height: isExpandedFloor[index][row][floor][0] == true ? 40 : 0,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.vertical(
                                                                  top: Radius.circular(isRoomTopRadius[index][row][floor][room] == true ? 5 : 0),
                                                                  bottom: Radius.circular(isRoomBottomRadius[index][row][floor][room] == true ? 5 : 0),
                                                                ),
                                                                color: Color(0x116D669D),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text("ห้อง ${horPukData[index].row[row].floor[floor].rooms[room].roomName}", style: GoogleFonts.prompt(fontSize: 17)),
                                                                    Row(
                                                                      children: [
                                                                        Text("สถานะ : ",style: GoogleFonts.prompt(fontSize: 16)),
                                                                        Icon((horPukData[index].row[row].floor[floor].rooms[room].paymentStatus.icon) , color: horPukData[index].row[row].floor[floor].rooms[room].paymentStatus.iconColor, size: 24)
                                                                      ],
                                                                    ),
                                                                    ShowDetail(index: index,row:row,floor:floor,room:room),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
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
  }
}
