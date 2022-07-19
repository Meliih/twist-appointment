import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/Models/Globals.dart' as globals;

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: CircleAvatar(
                        backgroundImage: new AssetImage("image/girl.png"),
                        radius: 31.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        globals.username,
                        style: GoogleFonts.poiretOne(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            buildTextField(),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x17000000),
                    offset: Offset(0, 15),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                'Kaydet',
                style: GoogleFonts.poiretOne(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTextField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(19)),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        children: <Widget>[
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Göğüs Ölçüsü",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            obscureText: false,
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Göğüs Altı",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            obscureText: false,
            decoration: InputDecoration(
              labelText: "Bel",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Karın",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Kalça",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Basen",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Sağ Üst Bacak",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Sol Üst Bacak",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Sağ Üst Kol",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
          TextField(
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              labelText: "Sol Üst Kol",
              enabledBorder: InputBorder.none,
              labelStyle: GoogleFonts.poiretOne(
                color: Color(0xff363636),
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
