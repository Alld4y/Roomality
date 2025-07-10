import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/services/api_service.dart';
import 'package:roomality/widgets/mainPage.dart';
import 'package:video_player/video_player.dart';
import 'package:roomality/fragments/Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializedVideoPlayerFuture;
  final _formKey = GlobalKey<FormState>();
  String? _username, _password;
  Color textFieldColor = const Color.fromARGB(153, 255, 255, 255);

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFA695AF), Color(0xff9e8da9)],
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
                  return const SizedBox(height: 0);
                }
              },
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/Login.png",
                    color: const Color.fromARGB(195, 81, 61, 117),
                    height: 200,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "ชื่อผู้ใช้",
                            style: GoogleFonts.prompt(fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextFormField(
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'กรุณากรอกชื่อผู้ใช้'
                                        : null,
                            onSaved: (value) => _username = value,
                            maxLength: 40,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "",
                              filled: true,
                              fillColor: textFieldColor,
                              border: const OutlineInputBorder(
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
                            "รหัสผ่าน",
                            style: GoogleFonts.prompt(fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            validator:
                                (value) =>
                                    value == null || value.length < 6
                                        ? 'รหัสผ่านต้องมากกว่า 6 ตัวอักษร'
                                        : null,
                            onSaved: (value) => _password = value,
                            maxLength: 30,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "",
                              filled: true,
                              fillColor: textFieldColor,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(
                                          'เข้าสู่ระบบสำเร็จ',
                                          style: GoogleFonts.prompt(),
                                        ),
                                        content: Text(
                                          'ชื่อผู้ใช้: $_username',
                                          style: GoogleFonts.prompt(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () async {
                                                  Navigator.pop(context);

                                                  bool login_status = await ApiService.userLogin(_username!, _password!);
                                                  print(login_status);
                                                    if (login_status) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => MainPage()),
                                                      );
                                                    }
                                                },
                                            child: Text(
                                              'ตกลง',
                                              style: GoogleFonts.prompt(),
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                               
                              }
                            },
                            child: const Text("เข้าสู่ระบบ"),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              'สมัครสมาชิก',
                              style: GoogleFonts.prompt(
                                color: Color.fromARGB(255, 96, 90, 138),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
