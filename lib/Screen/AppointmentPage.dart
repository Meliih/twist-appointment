import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/Models/Appointment.dart';
import 'package:twist/NavigationDrawer.dart';

import 'NotificationScreen.dart';
import 'UserPageScreen.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<Appointment> appointments = [
    Appointment(25, 7, 2022, "12:00", "Kahramanım Melih", "Ömer")
  ];

  List<String> trDays = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        //centerTitle: true,
        actions: [],
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (BuildContext context, int index) {
                return demoTopRatedDr(context, appointments[index]);
              })),
    );
  }

  Widget demoTopRatedDr(BuildContext context, Appointment appointment) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      width: size.width - 40,
      margin: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width - 130,
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${appointment.clock}  ${appointment.day} / ${appointment.month} / ${appointment.year} ${trDays[DateTime(appointment.year, appointment.month, appointment.day).weekday - 1]}",
                    style: GoogleFonts.poiretOne(
                      color: Color(0xff363636),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointment.trainerName,
                        style: GoogleFonts.poiretOne(
                          color: Color(0xff363636),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Puan: " + appointment.userName,
                        style: GoogleFonts.poiretOne(
                          color: Color(0xff363636),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red,
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                size: 45,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
