import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:twist/Models/AppointmentDate.dart';
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
  var selectedDay;
  var selectedHour;

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

  List<String> turkishDays = List<String>.filled(10, "0");

  late Future<List<String>> clocksWeekDays;
  late Future<List<String>> clocksWeekend;

  final trDays = [
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
    return initWidget(context, widget.trainer);
  }

  Widget initWidget(BuildContext context, Trainer trainer) {
    List<DateTime> days = possibleAppointment();

    AppointmentDate _appointmentDate = AppointmentDate("", "", false);
    String month = DateFormat("M").format(DateTime.now());
    String year = DateFormat("y").format(DateTime.now());

    clocksWeekDays = _appointmentDate.getweekdayClocks(
        "9", "2022", (selectedDay + 1).toString());

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
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
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
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:
                            selectedDay == index ? Colors.purple : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedDay = index;
                        });
                        print(selectedDay);
                      },
                      child: demoDates(turkishDays[index],
                          days[index].day.toString(), index),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
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
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              margin: EdgeInsets.only(right: 20, left: 20),
              child: buildGrid(),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }

  Widget demoDates(String day, String date, int index) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 80,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  day,
                  style: GoogleFonts.poiretOne(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(7),
                child: Text(
                  date,
                  style: GoogleFonts.poiretOne(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget doctorTimingsData(String time, int index) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
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
                  time,
                  style: GoogleFonts.poiretOne(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<DateTime> possibleAppointment() {
    List<DateTime> days = List<DateTime>.filled(10, DateTime(20, 1, 1));

    for (int i = 0; i < days.length; i++) {
      days[i] = DateTime(time.year, time.month, time.day + i);
      turkishDays[i] = trDays[days[i].weekday - 1];
    }
    return days;
  }

  FutureBuilder<List<String>> buildGrid() {
    bool isWeekend = false;

    return FutureBuilder<List<String>>(
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
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        selectedHour == index ? Colors.purple : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedHour = index;
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
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
