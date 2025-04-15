import 'package:flutter/material.dart';

class HorPukRoom extends StatefulWidget {
  final int index;
  final int row;
  final int floor;
  final int room;
  const HorPukRoom({super.key, required this.index, required this.row, required this.floor, required this.room});

  @override
  State<HorPukRoom> createState() => _HorPukRoomState();
}

class _HorPukRoomState extends State<HorPukRoom> {
  @override
  Widget build(BuildContext context) {
    return Text("${widget.index} - ${widget.row} - ${widget.floor} ${widget.room}");
  }
}