import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:twist/Models/AppointmentDate.dart';
import 'package:twist/Models/Clock.dart';
import 'package:twist/Models/Day.dart';
import 'DbHelper.dart';
import 'package:intl/intl.dart';

import 'Models/Trainer.dart';

class DoctorDetailPage extends StatefulWidget {
  final Trainer trainer;
  const DoctorDetailPage({
    Key? key,
    required this.trainer,
  }) : super(key: key);

  @override
  _DoctorDetailState createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetailPage> {
  DateTime time = DateTime.now();

  bool gridUse = false;
  var selectedDay = 0;
  var selectedHour = 0;

  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  AppointmentDate _appointmentDate = AppointmentDate("", "", false);

  late Future<List<Clock>> clocksWeekDays;
  late Future<List<String>> clocksWeekend;

  @override
  Widget build(BuildContext context) {
    return initWidget(context, widget.trainer);
  }

  Widget initWidget(BuildContext context, Trainer trainer) {
    //_appointmentDate.getDay(this.widget.trainer.name, 1, 7, 2022);

    String month = DateFormat("M").format(DateTime.now());
    String year = DateFormat("y").format(DateTime.now());
    Future<List<Day>> days =
        _appointmentDate.getDaysByMonth(month, year, trainer.name);

    clocksWeekDays = _appointmentDate.getweekdayClocks(
        month, year, (selectedDay + 1).toString(), trainer.name);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Container(
                margin: EdgeInsets.only(left: 30, bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        trainer.img,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              trainer.name,
                              style: GoogleFonts.poiretOne(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              trainer.domain,
                              style: GoogleFonts.poiretOne(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Puan: ' + trainer.rating,
                              style: GoogleFonts.poiretOne(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                months[time.month - 1] + " " + time.year.toString(),
                style: GoogleFonts.poiretOne(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              height: 90,
              child: FutureBuilder<List<Day>>(
                  future: days,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  primary: selectedDay == index
                                      ? Colors.purple
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedDay = index;
                                  });
                                  //print(selectedDay);
                                },
                                child: demoDates(snapshot.data![index], index),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30, bottom: 20),
              child: Text(
                'Saatler',
                style: GoogleFonts.poiretOne(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: buildGrid(),
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xff107163),
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
                  'Randevu Al',
                  style: GoogleFonts.poiretOne(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoDates(Day day, int index) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              day.name,
              style: GoogleFonts.poiretOne(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            //padding: EdgeInsets.all(7),
            child: Text(
              day.day,
              style: GoogleFonts.poiretOne(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorTimingsData(Clock time, int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Icon(
              Icons.access_time,
              color: Colors.black,
              size: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2),
            child: Text(
              time.name,
              style: GoogleFonts.poiretOne(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Clock>> buildGrid() {
    bool isWeekend = false;

    return FutureBuilder<List<Clock>>(
        future: clocksWeekDays,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index) {
                if (snapshot.data![index].isActive == false) {
                  return Container(
                    alignment: Alignment.center,
                    child: doctorTimingsData(snapshot.data![index], index),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5)),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          selectedHour == index ? Colors.purple : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedHour = index;
                        print(selectedHour);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: doctorTimingsData(snapshot.data![index], index),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.0),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
