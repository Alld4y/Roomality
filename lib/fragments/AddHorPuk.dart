import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/main.dart';
import 'package:roomality/models/DropDownList.dart';
import 'package:roomality/models/room.dart';
import 'package:roomality/provider/HorPukProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddHorPukFragment extends StatefulWidget {
  const AddHorPukFragment({super.key});

  @override
  State<AddHorPukFragment> createState() => _AddHorPukFragmentState();
}

class _AddHorPukFragmentState extends State<AddHorPukFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "เพิ่มข้อมูลห้องเช่า",
          style: GoogleFonts.prompt(
            fontSize: 20,
            color: Color.fromARGB(255, 66, 62, 95),
          ),
        ),
        // logo image
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset(
        //   'assets/images/roomality.png',
        //   fit: BoxFit.cover,
        //   ),
        // ),
        backgroundColor: Color.fromARGB(255, 157, 139, 167),
        //backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: AddHorPuk(),
    );
  }
}

class AddHorPuk extends StatefulWidget {
  const AddHorPuk({super.key});

  @override
  State<AddHorPuk> createState() => _AddHorPukState();
}

class _AddHorPukState extends State<AddHorPuk> {
  Color textFieldColor = Color.fromARGB(153, 255, 255, 255);
  late VideoPlayerController _controller;
  late Future<void> _initializedVideoPlayerFuture;
  final _formKey = GlobalKey<FormState>();
  String? horPukNameInput;
  int? horPukMonthlyPriceInput;
  int? horPukDepositPriceInput;
  int? horPukContract;
  int _numberOfRow = 1;
  late List<List<bool>> _horPukFloor;
  List<bool> _horPukRow = [true];
  bool _allRowsHaveSameFloor = false;
  late List<bool> _allFloorsHaveSameRoom = [];
  late List<List<List<bool>>> _horPukRoom = [];
  late List<List<List<bool>>> _tempHorPukRoom = [];


  bool initHorPukRoomValid = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset("assets/videos/animated01.mp4");
    _initializedVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(0.0);
    _controller.play();

    super.initState();

    _numberOfRow = 1;
    _horPukRow = List.generate(_numberOfRow, (index) => false);
    _horPukFloor = List.generate(_numberOfRow, (row) => [false]);
    _allFloorsHaveSameRoom = List.generate(_numberOfRow, (row) => false);
    _horPukRoom = List.generate(
      _numberOfRow,
      (_) => [
        [false],
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HorPukProvider>(
      builder: (context, HorPukProvider horPukProvider, Widget? child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFA695AF), // สีบน
                        Color(0xff9e8da9), // สีล่าง
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: FutureBuilder(
                    future: _initializedVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return SizedBox(height: 0);
                      }
                    },
                  ),
                ),

                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/Pastel Purple Retro Bold Cafe Logo.png",
                          color: Color.fromARGB(195, 81, 61, 117),
                          height: 200,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0x66FFFFFF),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0x00FFFFFF),
                                Color(0xEEFFFFFF),
                                Color(0xEEFFFFFF),

                              ],
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "ชื่อหอพัก",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "กรุณากรอกชื่อหอพัก";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        horPukNameInput = value;
                                      },
                                      maxLength: 9,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        filled: true,
                                        fillColor: textFieldColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "ราคาห้องเช่า (บาท/เดือน)",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "กรุณากรอกราคาห้องเช่า";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        horPukMonthlyPriceInput= int.parse(value.toString());
                                      },
                                      maxLength: 5,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        filled: true,
                                        fillColor: textFieldColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "เงินประกัน/เงินมัดจำ",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "กรุณากรอกเงินประกัน/เงินมัดจำ";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        horPukDepositPriceInput = int.parse(value.toString());
                                      },
                                      maxLength: 5,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        filled: true,
                                        fillColor: textFieldColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "สัญญาเช่า (เดือน)",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "กรุณากรอกสัญญาเช่า";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        horPukContract = int.parse(value.toString());
                                      },
                                      maxLength: 5,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        filled: true,
                                        fillColor: textFieldColor,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "จำนวนแถว",
                                      style: GoogleFonts.prompt(fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 80,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<int>(
                                        value: _numberOfRow,
                                        isExpanded: true,
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              252,
                                              248,
                                              255,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          direction:
                                              DropdownDirection.textDirection,
                                          maxHeight: 150,
                                          width: 80,
                                          padding: EdgeInsets.all(8),
                                        ),
                                        alignment: Alignment.center,
                                        buttonStyleData: ButtonStyleData(
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: textFieldColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 0,
                                          ),
                                        ),
                                        items:
                                            DropDownList().number.map((item) {
                                              return DropdownMenuItem<int>(
                                                value: item,
                                                child: Center(
                                                  child: Text(item.toString()),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (value) {
                                          // Handle dropdown value change
                                          setState(() {
                                            // Main Row Select
                                            _numberOfRow = int.parse(
                                              value.toString(),
                                            );
                                            _horPukRow = List.generate(
                                              _numberOfRow,
                                              (index) => false,
                                            );
                                            _horPukFloor = List.generate(
                                              _numberOfRow,
                                              (row) => [false],
                                            );
                                            _allFloorsHaveSameRoom = List.generate(
                                              _numberOfRow,
                                              (row) => false,
                                            );
                                            print("_horPukFloor = $_horPukFloor");
                                            _horPukFloor = List.generate(
                                              _horPukRow.length,
                                              (row) => [],
                                            );
                                            _horPukFloor = List.generate(
                                              _numberOfRow,
                                              (row) =>
                                                  List.generate(1, (_) => false),
                                            );
                                            _horPukRoom = List.generate(
                                              _numberOfRow,
                                              (_) => [
                                                [false],
                                              ],
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(
                                  color: Colors.grey,
                                  thickness: 1, // ความหนา
                                  height: 0,   // ช่องว่างแนวตั้ง
                                  indent: MediaQuery.of(context).size.width * 0.2,   // ขอบซ้าย
                                  endIndent: MediaQuery.of(context).size.width * 0.2, // ขอบขวา
                                ),
                                  Center(
                                    child: SizedBox(
                                      width: 300,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left:
                                              MediaQuery.of(context).size.width *
                                              0.07,
                                        ),
                                        child: CheckboxListTile(
                                          title: Text("กำหนดทีละชั้น / ห้อง"),
                                          activeColor: Color.fromARGB(
                                            195,
                                            81,
                                            61,
                                            117,
                                          ),
                                          value: _allRowsHaveSameFloor,
                                          onChanged: (bool? val) {
                                            setState(() {
                                              _allFloorsHaveSameRoom =
                                                  List.generate(
                                                    _horPukRow.length,
                                                    (row) => false,
                                                  );
                                              _allRowsHaveSameFloor = val!;
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          tileColor: Color.fromARGB(
                                            50,
                                            255,
                                            255,
                                            255,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                  color: Colors.grey,
                                  thickness: 1, // ความหนา
                                  height: 0,   // ช่องว่างแนวตั้ง
                                  indent: MediaQuery.of(context).size.width * 0.2,   // ขอบซ้าย
                                  endIndent: MediaQuery.of(context).size.width * 0.2, // ขอบขวา
                                ),
                                  SizedBox(height: 20),
                                  _allRowsHaveSameFloor // ชั้นไม่เท่ากัน
                                      ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.8,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _horPukRow.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0x77FFFFFF),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    10.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  MediaQuery.of(
                                                                    context,
                                                                  ).size.width *
                                                                  0.02,
                                                            ),
                                                        child: Text(
                                                          "แถวที่ ${index + 1}",
                                                          style: GoogleFonts.prompt(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        // ชั้นไม่เท่ากัน
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                5.0,
                                                              ),
                                                          child: Text(
                                                            "จำนวนชั้น/แถว",
                                                            style:
                                                                GoogleFonts.prompt(
                                                                  fontSize: 18,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 80,
                                                          child: DropdownButtonHideUnderline(
                                                            child: DropdownButton2<
                                                              int
                                                            >(
                                                              value:
                                                                  _horPukFloor[index]
                                                                      .length,
                                                              isExpanded: true,
                                                              dropdownStyleData: DropdownStyleData(
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        252,
                                                                        248,
                                                                        255,
                                                                      ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                        Radius.circular(
                                                                          10,
                                                                        ),
                                                                      ),
                                                                ),
                                                                direction:
                                                                    DropdownDirection
                                                                        .textDirection,
                                                                maxHeight: 150,
                                                                width: 80,
                                                                padding:
                                                                    EdgeInsets.all(
                                                                      8,
                                                                    ),
                                                              ),
                                                              alignment:
                                                                  Alignment.center,
                                                              buttonStyleData: ButtonStyleData(
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      textFieldColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                        Radius.circular(
                                                                          100,
                                                                        ),
                                                                      ),
                                                                ),
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      horizontal: 0,
                                                                    ),
                                                              ),
                                                              items:
                                                                  DropDownList().number.map((
                                                                    item,
                                                                  ) {
                                                                    return DropdownMenuItem<
                                                                      int
                                                                    >(
                                                                      value: item,
                                                                      child: Center(
                                                                        child: Text(
                                                                          item.toString(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                              onChanged: (value) {
                                                                // Floor Select when not same length
                                                                setState(() {
                                                                  // ชั้นไม่เท่ากัน
                                                                  _horPukFloor[index] =
                                                                      List.generate(
                                                                        int.parse(
                                                                          value
                                                                              .toString(),
                                                                        ),
                                                                        (_) => true,
                                                                      );
                                                                      print("_horPukRoom = $_horPukRoom");
                                                                 if(!initHorPukRoomValid){
                                                                  _horPukRoom =  _tempHorPukRoom;
                                                                   _horPukRoom =
                                                                      List.generate(
                                                                        _numberOfRow,
                                                                        (
                                                                          _,
                                                                        ) => List.generate(
                                                                          int.parse(
                                                                            value
                                                                                .toString(),
                                                                          ),
                                                                          (_) => [
                                                                            false,
                                                                          ],
                                                                        ),
                                                                      );
                                                                  initHorPukRoomValid = true;
                            
                                                                 }else{
                                                                  _horPukRoom[index] = List.generate(int.parse(value.toString()), (_) => [false]);
                                                                 }
                                                                  print("_horPukFloor = $_horPukFloor");
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: SizedBox(
                                                          width: 300,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  left:
                                                                      MediaQuery.of(
                                                                        context,
                                                                      ).size.width *
                                                                      0.04,
                                                                ),
                                                            child: CheckboxListTile(
                                                              // จำนวนห้องไม่เท่ากัน
                                                              title: Text(
                                                                "จำนวนห้องไม่เท่ากัน",
                                                              ),
                                                              activeColor:
                                                                  Color.fromARGB(
                                                                    195,
                                                                    81,
                                                                    61,
                                                                    117,
                                                                  ),
                                                              value:
                                                                  _allFloorsHaveSameRoom[index],
                                                              onChanged: (
                                                                bool? val,
                                                              ) {
                                                                setState(() {
                                                                  _allFloorsHaveSameRoom[index] =
                                                                      !_allFloorsHaveSameRoom[index];
                                                                });
                                                                print("_allFloorsHaveSameRoom = $_allFloorsHaveSameRoom");
                                                              },
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .leading,
                                                              tileColor:
                                                                  Color.fromARGB(
                                                                    50,
                                                                    255,
                                                                    255,
                                                                    255,
                                                                  ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      _allFloorsHaveSameRoom[index]
                                                          ? Center(
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                    context,
                                                                  ).size.width *
                                                                  0.7,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                      Radius.circular(
                                                                        10,
                                                                      ),
                                                                    ),
                                                                color: Color(
                                                                  0xAAFFFFFF,
                                                                ),
                                                              ),
                                                              child: ListView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    _horPukFloor[index]
                                                                        .length,
                                                                itemBuilder: (
                                                                  context,
                                                                  floor,
                                                                ) {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets.symmetric(
                                                                          vertical:
                                                                              8.0,
                                                                        ),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                8,
                                                                            horizontal:
                                                                                MediaQuery.of(
                                                                                  context,
                                                                                ).size.width *
                                                                                0.02,
                                                                          ),
                                                                          child: Text(
                                                                            "ชั้นที่ ${floor + 1}",
                                                                            style: GoogleFonts.prompt(
                                                                              fontSize:
                                                                                  18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(
                                                                                  6.0,
                                                                                ),
                                                                            child: Text(
                                                                              "จำนวนห้อง/ชั้น",
                                                                              style: GoogleFonts.prompt(
                                                                                fontSize:
                                                                                    17,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child: SizedBox(
                                                                            width:
                                                                                80,
                                                                            height:
                                                                                40,
                                                                            child: DropdownButtonHideUnderline(
                                                                              child: DropdownButton2(
                                                                                value:
                                                                                    _horPukRoom[index][floor].length,
                                                                                isExpanded:
                                                                                    true,
                                                                                dropdownStyleData: DropdownStyleData(
                                                                                  maxHeight: 150,
                                                                                  width:
                                                                                      80,
                                                                                  direction:
                                                                                      DropdownDirection.textDirection,
                            
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color.fromARGB(
                                                                                      255,
                                                                                      252,
                                                                                      248,
                                                                                      255,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(
                                                                                        10,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                buttonStyleData: ButtonStyleData(
                                                                                  width:
                                                                                      80,
                                                                                  decoration: BoxDecoration(
                                                                                    color:
                                                                                        textFieldColor,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(
                                                                                        100,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onChanged: (
                                                                                  value,
                                                                                ) {
                                                                                  setState(() {
                                                                                    _horPukRoom[index][floor] = List.generate(int.parse(value.toString()), (_) => true);
                                                                                  print(
                                                                                    "_horPukRoom $_horPukRoom",
                                                                                  );
                                                                                  });
                                                                                },
                                                                                items:
                                                                                    List.generate(20, (index)=>index+1).map((
                                                                                      item,
                                                                                    ) {
                                                                                      return DropdownMenuItem(
                                                                                        value:
                                                                                            item,
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            item.toString(),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }).toList(),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                          : SizedBox(height: 0),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      : Column(
                                        // ชั้นเท่ากัน
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "จำนวนชั้น/ทุกแถว", // Have a same floor length
                                              style: GoogleFonts.prompt(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 80,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<int>(
                                                value: _horPukRoom[0].length,
                                                isExpanded: true,
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                          255,
                                                          252,
                                                          248,
                                                          255,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(10),
                                                            ),
                                                      ),
                                                      direction:
                                                          DropdownDirection
                                                              .textDirection,
                                                      maxHeight: 150,
                                                      width: 80,
                                                      padding: EdgeInsets.all(8),
                                                    ),
                                                alignment: Alignment.center,
                                                buttonStyleData: ButtonStyleData(
                                                  decoration: BoxDecoration(
                                                    color: textFieldColor,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(100),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                  ),
                                                ),
                                                items:
                                                    DropDownList().number.map((
                                                      item,
                                                    ) {
                                                      return DropdownMenuItem<int>(
                                                        value: item,
                                                        child: Center(
                                                          child: Text(
                                                            item.toString(),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                onChanged: (value) {
                                                  // Handle dropdown value change
                                                  setState(() {
                                                    _horPukRoom = List.generate(int.parse(_numberOfRow.toString()), (_) => List.generate(int.parse(value.toString()), (_) => [false]));
                                                    initHorPukRoomValid = false;
                            
                                                    print("_horPukRoom = $_horPukRoom");
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "จำนวนห้อง/ทุกชั้น", // Have a same floor length
                                              style: GoogleFonts.prompt(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 80,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<int>(
                                                value: _horPukRoom[0][0].length,
                                                isExpanded: true,
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                          255,
                                                          252,
                                                          248,
                                                          255,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(10),
                                                            ),
                                                      ),
                                                      direction:
                                                          DropdownDirection
                                                              .textDirection,
                                                      maxHeight: 150,
                                                      width: 80,
                                                      padding: EdgeInsets.all(8),
                                                    ),
                                                alignment: Alignment.center,
                                                buttonStyleData: ButtonStyleData(
                                                  decoration: BoxDecoration(
                                                    color: textFieldColor,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(100),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 0,
                                                  ),
                                                ),
                                                items:
                                                    List.generate(20, (index)=>index+1).map((
                                                      item,
                                                    ) {
                                                      return DropdownMenuItem<int>(
                                                        value: item,
                                                        child: Center(
                                                          child: Text(
                                                            item.toString(),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                onChanged: (value) {
                                                  // Handle dropdown value change
                                                  setState(() {
                                                    for(int row = 0 ; row < _horPukRoom.length ; row++){
                                                      for(int floor = 0 ; floor < _horPukRoom[row].length ; floor++){
                                                        _horPukRoom[row][floor] = List.generate(int.parse(value.toString()), (_) => true);
                                                      }
                                                    }
                                                    initHorPukRoomValid = false;
                            
                                                    print("_horPukRoom = $_horPukRoom");
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          // End Same Length
                                        ],
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.validate();
                              _formKey.currentState!.save();
                              List<HorPukRow> horPuk = [];

                              for(int row = 0 ; row < _horPukRoom.length ; row++){
                                horPuk.add(HorPukRow(rowName: "แถวที่ ${row+1}", floor: []));
                                for(int floor = 0 ; floor < _horPukRoom[row].length ; floor++){
                                  print(horPuk);
                                  horPuk[row].floor.add(HorPukFloor(floorName: "ชั้นที่ ${floor+1}", rooms: []));
                                  for(int room = 0 ; room < _horPukRoom[row][floor].length ; room++){
                                    horPuk[row].floor[floor].rooms.add(SubRoom(paymentStatus: PaymentStatus.noTenant, roomName: "${row+1}${_horPukRoom[row].length == 1 ? "" : floor+1}${room+1 > 9 ? room+1 : "0${room+1}"}", monthlyPrice: int.parse(horPukMonthlyPriceInput.toString()), depositPrice: int.parse(horPukDepositPriceInput.toString()), rentalStartUnix: DateTime.now(), contract: int.parse(horPukContract.toString())));
                                  }
                                }
                              }
                              print(horPuk[0].floor[0].rooms.length);

                              horPukProvider.createHorPuk(horPukNameInput, horPuk);
                              


                              // for(var horPuk in horPukProvider.horPukData){
                              //   if(horPuk.horPukName == horPukNameInput){
                                  
                              //   }
                              // }

                              _formKey.currentState!.reset();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const Home(),
                                ), // MaterialPageRoute
                              );
                            },
                            child: Text("ยืนยัน"),
                          ),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
