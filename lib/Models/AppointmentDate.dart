import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:twist/Models/Clock.dart';
import 'package:twist/Models/Day.dart';

class AppointmentDate {
  AppointmentDate(
    this.day,
    this.clock,
    this.isActive,
  );

  final String day;
  final String clock;
  final bool isActive;

  factory AppointmentDate.fromJson(Map<String, dynamic> json) =>
      AppointmentDate(
        json["day"],
        json["clock"],
        json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "clock": clock,
        "isActive": isActive,
      };

  final trDays = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar",
  ];

  getDay(String trainerName, int day, int month, int year) {
    for (DateTime indexDay = DateTime(year, month, day);
        indexDay.compareTo(DateTime(2023, 12, 31)) < 0;
        indexDay = indexDay.add(Duration(days: 1)))
      if (trDays[indexDay.weekday - 1] == "Pazar" ||
          trDays[indexDay.weekday - 1] == "Cumartesi") {
        writeData(indexDay.day, indexDay.month, indexDay.year,
            trDays[indexDay.weekday - 1], true, trainerName);
      } else {
        writeData(indexDay.day, indexDay.month, indexDay.year,
            trDays[indexDay.weekday - 1], false, trainerName);
      }
  }

  void writeData(int day, int month, int year, String weekDay, bool isWeekend,
      String trainerName) {
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("AppointmentDays/${month}-${year}/${trainerName}/${day}");
    if (!isWeekend) {
      reference.set({
        "name": "${weekDay}",
        "clocks": {
          "10:00": {
            "isActive": true,
            "count": 0,
          },
          "11:00": {
            "isActive": true,
            "count": 0,
          },
          "12:00": {
            "isActive": true,
            "count": 0,
          },
          "13:00": {
            "isActive": true,
            "count": 0,
          },
          "14:00": {
            "isActive": true,
            "count": 0,
          },
          "15:00": {
            "isActive": true,
            "count": 0,
          },
          "16:00": {
            "isActive": true,
            "count": 0,
          },
          "17:00": {
            "isActive": true,
            "count": 0,
          },
          "18:00": {
            "isActive": true,
            "count": 0,
          },
          "19:00": {
            "isActive": true,
            "count": 0,
          },
          "20:00": {
            "isActive": true,
            "count": 0,
          },
          "21:00": {
            "isActive": true,
            "count": 0,
          }
        }
      });
    } else {
      reference.set({
        "name": "${weekDay}",
        "clocks": {
          "10:00": {
            "isActive": true,
            "count": 0,
          },
          "11:00": {
            "isActive": true,
            "count": 0,
          },
          "12:00": {
            "isActive": true,
            "count": 0,
          },
          "13:00": {
            "isActive": true,
            "count": 0,
          },
          "14:00": {
            "isActive": true,
            "count": 0,
          },
          "15:00": {
            "isActive": true,
            "count": 0,
          }
        }
      });
    }
  }

  Future<List<Clock>> getweekdayClocks(
      String month, String year, String day, String trainerName) async {
    List<Clock> clocks = [];
    final event = await FirebaseDatabase.instance
        .ref('AppointmentDays/${month}-${year}/${trainerName}/${day}/clocks')
        .once();

    final data = event.snapshot.children;

    Clock clock;
    // child name
    data.forEach((element) {
      String value = element.key.toString();
      // add to list
      bool isActive = element.child("isActive").value as bool;
      int count = int.parse(element.child("count").value.toString());
      clock = Clock(value, isActive, count);
      //print(isActive);
      clocks.add(clock);
      //print(value);
    });
    return clocks;
  }

  Future<List<Day>> getDaysByMonth(
      String month, String year, String trainerName) async {
    List<Day> daysMonth = [];
    final event = await FirebaseDatabase.instance
        .ref('AppointmentDays/${month}-${year}/${trainerName}')
        .once();

    final data = event.snapshot.children;
    // child name
    Day day;
    data.forEach((element) {
      String value = element.key.toString();
      // add to list
      String days = element.child("name").value.toString();
      day = Day(days, value);
      daysMonth.add(day);
      //print(value);
    });
    return daysMonth;
  }
}
