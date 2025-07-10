import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/services/api_service.dart';
import 'package:video_player/video_player.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializedVideoPlayerFuture;
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _password;
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
                    "assets/images/Register.png",
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
                            "ชื่อ",
                            style: GoogleFonts.prompt(fontSize: 18),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextFormField(
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'กรุณากรอกชื่อ'
                                        : null,
                            onSaved: (value) => _name = value,
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "อีเมล",
                            style: GoogleFonts.prompt(fontSize: 18),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextFormField(
                            validator:
                                (value) =>
                                    value == null || !value.contains('@')
                                        ? 'กรุณากรอกอีเมลที่ถูกต้อง'
                                        : null,
                            onSaved: (value) => _email = value,
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
                          width: MediaQuery.of(context).size.width * 0.6,
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
                                // TODO: ส่งข้อมูลไป backend หรือแสดงผลลัพธ์
                                print(_name);
                                print(_password);
                                print(_email);
                                ApiService.userRegister(_name!,_password!,_email!);
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(
                                          'สมัครสมาชิกสำเร็จ',
                                          style: GoogleFonts.prompt(),
                                        ),
                                        content: Text(
                                          'ชื่อ: $_name\nอีเมล: $_email',
                                          style: GoogleFonts.prompt(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
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
                            child: const Text("สมัครสมาชิก"),
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
