import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twist/Models/Globals.dart' as globals;
import 'package:twist/Models/TrainerService.dart';

class TrainerHomePage extends StatefulWidget {
  const TrainerHomePage({Key? key}) : super(key: key);

  @override
  State<TrainerHomePage> createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  @override
  Widget build(BuildContext context) {
    TrainerService().writeData(8, 8, 2022, "Kadriye Yerlikaya", "10:00");
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                backgroundImage: new AssetImage("image/girl.png"),
                radius: 22.0,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          children: [
            Container(
              width: size.width - 40,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Sayın, ${globals.username}",
                style: GoogleFonts.poiretOne(
                  color: Color(0xff363636),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Randevu kapat"),
            buildLine(size),
          ],
        ),
      ),
    );
  }

  buildLine(Size size) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToCollapse: true,
        hasIcon: true,
        iconSize: 20,
        iconColor: Colors.red,
      ),
      header: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text("Randevularım",
            style: GoogleFonts.poiretOne(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )),
      ),
      collapsed: const Text(""),
      expanded: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            width: size.width,
            //height: size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: (size.width - 30) / 8 * 3,
                      decoration: BoxDecoration(color: Colors.white),
                      child: AutoSizeText('Alacaklı',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                    ),
                    Container(
                      width: (size.width - 30) / 8 * 5,
                      decoration: BoxDecoration(color: Colors.white),
                      child: AutoSizeText(
                        ': "alacakli"',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: (size.width - 30) / 8 * 3,
                      child: AutoSizeText('Borçlu',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                    ),
                    Container(
                      width: (size.width - 30) / 8 * 5,
                      child: AutoSizeText(
                        ': "borclu"',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
