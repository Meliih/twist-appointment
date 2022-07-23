import 'package:firebase_database/firebase_database.dart';
import 'package:twist/Models/Globals.dart' as global;

int MAX_USER = 2;

class Appointment {
  late int day;
  late int month;
  late int year;
  late String clock;
  late String trainerName;
  late String userName;

  Appointment(
    this.day,
    this.month,
    this.year,
    this.clock,
    this.trainerName,
    this.userName,
  );

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        json["day"],
        json["month"],
        json["year"],
        json["clock"],
        json["trainerName"],
        json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
        "clock": clock,
        "trainerName": trainerName,
        "userName": userName,
      };

  newAppointment(Appointment appointment, String categoryName) async {
    FirebaseDatabase.instance
        .ref(
            "AppointmentDays/${appointment.month}-${appointment.year}/${appointment.trainerName}/${appointment.day}/clocks/${appointment.clock}/count")
        .once()
        .then((event) {
      final count = event.snapshot.value.toString();
      if (int.parse(count) <= MAX_USER) {
        DatabaseReference reference1 = FirebaseDatabase.instance.reference().child(
            "AppointmentDays/${appointment.month}-${appointment.year}/${appointment.trainerName}/${appointment.day}/clocks/${appointment.clock}/count");
        reference1.set('${int.parse(count) + 1}');

        DatabaseReference reference = FirebaseDatabase.instance.reference().child(
            "Appointments/${categoryName}/${appointment.trainerName}/${appointment.userName}/${appointment.clock}-${appointment.day}-${appointment.month}-${appointment.year}");
        reference.set('true');
      }
    });
  }
}
