import 'package:flutter/material.dart';

class RoomFragment extends StatefulWidget {
  const RoomFragment({super.key , required this.index});
  final int index;

  @override
  State<RoomFragment> createState() => _RoomFragmentState();
}

class _RoomFragmentState extends State<RoomFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${widget.index}")),
    );
  }
}