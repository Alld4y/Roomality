import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "เพิ่มข้อมูลห้องเช่า",
            style: GoogleFonts.prompt(fontSize: 20, color: Color.fromARGB(255, 66, 62, 95)),
          ),
          backgroundColor: Color(0xFFA695AF),
          centerTitle: true,
          elevation: 0,
        ),
        body: AddRoom(),
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
  Color textFieldColor = Color.fromARGB(78, 255, 255, 255);
  late VideoPlayerController _controller;
  late Future<void> _initializedVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/animated01.mp4");
    _initializedVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(0.0);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            /// พื้นหลังไล่ระดับ
            Container(
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFA695AF),
                    Color(0xff9e8da9),
                  ],
                ),
              ),
            ),

            /// วิดีโอพื้นหลัง
            Positioned.fill(
              child: FutureBuilder(
                future: _initializedVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    return Container(); // loading state
                  }
                },
              ),
            ),

            /// แบบฟอร์มด้านบน
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/images/Pastel Purple Retro Bold Cafe Logo.png",
                      color: const Color.fromARGB(195, 81, 61, 117),
                      height: 200,
                    ),
                    _buildField("ชื่อห้องเช่า"),
                    _buildField("ค่าเช่ารายเดือน"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // ยืนยัน
                      },
                      child: const Text("ยืนยัน"),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// ฟังก์ชันสร้างช่องกรอกข้อความ
  Widget _buildField(String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(label, style: GoogleFonts.prompt(fontSize: 18)),
        ),
        Container(
          width: 250,
          height: 50,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: textFieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
