import 'package:firebase_database/firebase_database.dart';

class TrainerService {
  void writeData(
      int day, int month, int year, String trainerName, String clock) {
    DatabaseReference reference = FirebaseDatabase.instance.reference().child(
        "AppointmentDays/${month}-${year}/${trainerName}/${day}/clocks/${clock}/isActive");

    reference.set(false);
  }
}
