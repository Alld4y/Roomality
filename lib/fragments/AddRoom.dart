import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomality/main.dart';
import 'package:roomality/models/room.dart';
import 'package:roomality/provider/roomProvider.dart';
import 'package:video_player/video_player.dart';

class AddRoomFragment extends StatefulWidget {
  const AddRoomFragment({super.key});

  @override
  State<AddRoomFragment> createState() => _AddRoomFragmentState();
}

class _AddRoomFragmentState extends State<AddRoomFragment> {
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
      body: AddRoom(),
    );
  }
}

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  Color textFieldColor = Color.fromARGB(153, 255, 255, 255);
  late VideoPlayerController _controller;
  late Future<void> _initializedVideoPlayerFuture;
  final _formKey = GlobalKey<FormState>();
  String? _roomNameInput;
  int? _monthlyPriceInput;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset("assets/videos/animated01.mp4");
    _initializedVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(0.0);
    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, RoomProvider roomProvider, Widget? child) {
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "ชื่อห้องเช่า",
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
                                      return "กรุณากรอกชื่อห้องเช่า";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _roomNameInput = value;
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
                                  "ค่าเช่ารายเดือน",
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
                                      return "กรุณากรอกค่าเช่ารายเดือน";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (newValue) {
                                    _monthlyPriceInput = int.parse(
                                      newValue.toString(),
                                    );
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
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              _formKey.currentState!.validate();
                              _formKey.currentState!.save();
                              try {
                                roomProvider.createRoom(
                                  Room(
                                    roomName: _roomNameInput ?? '1',
                                    monthlyPrice: _monthlyPriceInput ?? 0,
                                    roomStatus: PaymentStatus.noTenant,
                                  ),
                                );
                                print(roomProvider.roomData);
                                _formKey.currentState!.reset();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const Home(),
                                  ),
                                  (route) => false, // MaterialPageRoute
                                );
                              } catch (e) {
                                // แสดง error dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'ข้อผิดพลาด',
                                        style: GoogleFonts.prompt(),
                                      ),
                                      content: Text(
                                        e.toString().replaceAll(
                                          'Exception: ',
                                          '',
                                        ),
                                        style: GoogleFonts.prompt(),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'ตกลง',
                                            style: GoogleFonts.prompt(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text("ยืนยัน"),
                          ),
                        ),
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
