import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/HomePage.dart';

class AppointmentConfirmation extends StatefulWidget {
  const AppointmentConfirmation({Key? key}) : super(key: key);

  @override
  State<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

Color themeColor = Colors.purple;

class _AppointmentConfirmationState extends State<AppointmentConfirmation> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //startTime();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 270,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Image.asset(
                  "image/green-tick.gif",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Teşekkürler!",
              style: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              "Randevunuz Alınmıştır",
              style: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Kısa süre içinde ana sayfaya yönlendirileceksiniz",
              textAlign: TextAlign.center,
              style: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var duration = new Duration(milliseconds: 1500);
    return Timer(
      duration,
      () => Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      })),
    );
  }
}
