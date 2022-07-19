import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/HomePage.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = Colors.purple;

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTime();
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
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Color(0xFF9C27B0),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/icons/message-notification.gif",
                fit: BoxFit.contain,
                //color: Colors.purple,
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
              "Mesajınız iletildi",
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
