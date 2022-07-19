import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

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

  getDay() {
    var month = DateFormat("M").format(DateTime.now());

    for (DateTime indexDay = DateTime(2022, 9, 1);
        indexDay.month == 9;
        indexDay = indexDay.add(Duration(days: 1)))
      if (trDays[indexDay.weekday - 1] == "Pazar" ||
          trDays[indexDay.weekday - 1] == "Cumartesi") {
        writeData(indexDay.day, indexDay.month, indexDay.year,
            trDays[indexDay.weekday - 1], true);
      } else {
        writeData(indexDay.day, indexDay.month, indexDay.year,
            trDays[indexDay.weekday - 1], false);
      }
  }

  void writeData(int day, int month, int year, String weekDay, bool isWeekend) {
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("AppointmentDays/${month}-${year}/${day}");
    if (!isWeekend) {
      reference.set({
        "name": "${weekDay}",
        "clocks": {
          "10:00": {
            "isActive": true,
          },
          "11:00": {
            "isActive": true,
          },
          "12:00": {
            "isActive": true,
          },
          "13:00": {
            "isActive": true,
          },
          "14:00": {
            "isActive": true,
          },
          "15:00": {
            "isActive": true,
          },
          "16:00": {
            "isActive": true,
          },
          "17:00": {
            "isActive": true,
          },
          "18:00": {
            "isActive": true,
          },
          "19:00": {
            "isActive": true,
          },
          "20:00": {
            "isActive": true,
          },
          "21:00": {
            "isActive": true,
          }
        }
      });
    } else {
      reference.set({
        "name": "${weekDay}",
        "clocks": {
          "10:00": {"isActive": true},
          "11:00": {"isActive": true},
          "12:00": {"isActive": true},
          "13:00": {"isActive": true},
          "14:00": {"isActive": true},
          "15:00": {"isActive": true}
        }
      });
    }
  }

  Future<List<String>> getweekdayClocks(
      String month, String year, String day) async {
    List<String> weekdayClocks = [];
    final event = await FirebaseDatabase.instance
        .ref('AppointmentDays/${month}-${year}/${day}/clocks')
        .once();

    final data = event.snapshot.children;
    // child name
    data.forEach((element) {
      String value = element.key.toString();
      // add to list
      weekdayClocks.add(value);
      print(value);
    });
    return weekdayClocks;
  }
}
