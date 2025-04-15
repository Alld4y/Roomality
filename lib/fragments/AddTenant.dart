import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomality/models/datePicker.dart';

class AddTenantFragment extends StatefulWidget {
  const AddTenantFragment({super.key});

  @override
  State<AddTenantFragment> createState() => _AddTenantFragmentState();
}

class _AddTenantFragmentState extends State<AddTenantFragment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roomality",
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("เพิ่มข้อมูลห้องเช่า", style: GoogleFonts.prompt(fontSize: 20, color: Color.fromARGB(255, 66, 62, 95))),
          // logo image
          // leading: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.asset(
          //   'assets/images/roomality.png',
          //   fit: BoxFit.cover,
          //   ),
          // ),
          backgroundColor: Color(0xFFA695AF),
          //backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
          body: AddRoom()
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
  Color textFieldColor = Color(0x33A695AF);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("ชื่อห้องเช่า", style :GoogleFonts.prompt(fontSize: 18)),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "",
                      filled: true,
                      fillColor: textFieldColor,
                      
                      border: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("ค่าเช่ารายเดือน", style :GoogleFonts.prompt(fontSize: 18)),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "",
                      filled: true,
                      fillColor: textFieldColor,
                      
                      border: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("จำนวนเงินมัดจำ", style :GoogleFonts.prompt(fontSize: 18)),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "",
                      filled: true,
                      fillColor: textFieldColor,
                      
                      border: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("วันที่เริ่มเช่า",style :GoogleFonts.prompt(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextField(
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
                        DropdownMenu(
                          initialSelection: "มกราคม",
                          onSelected: (value){
                            
                          },
                          dropdownMenuEntries: RoomalityDatePicker().month.map((value){
                            return DropdownMenuEntry(value: value, label: value);
                          }).toList(),
                          menuHeight: 200,
                        ),
                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                          child: TextField(
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("data", style :GoogleFonts.prompt(fontSize: 18)),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "",
                      filled: true,
                      fillColor: textFieldColor,
                      
                      border: OutlineInputBorder(
                        borderRadius: 
                        BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: ElevatedButton(onPressed: () {}, child: Text("ยืนยัน")))
          ],
        ),
      ),
    );
  }
}