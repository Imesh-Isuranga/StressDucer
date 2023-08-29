import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTable {
  TimeTable(
      {required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday,
      required this.freedays,
      required this.exam,
      required this.howManySubjectsPerDay
      });

  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;
  final String freedays;
  final String exam;
  final String howManySubjectsPerDay;

  factory TimeTable.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TimeTable(
        monday: snapshot['monday'],
        tuesday: snapshot['tuesday'],
        wednesday: snapshot['wednesday'],
        thursday: snapshot['thursday'],
        friday: snapshot['friday'],
        saturday: snapshot['saturday'],
        sunday: snapshot['sunday'],
        freedays: snapshot['freedays'],
        exam: snapshot['exam'],
        howManySubjectsPerDay: snapshot['howManySubjectsPerDay']);
  }

  Map<String,dynamic> toJson()=>{
    "monday":monday,
    "tuesday":tuesday,
    "wednesday":wednesday,
    "thursday":thursday,
    "friday":friday,
    "saturday":saturday,
    "sunday":sunday,
    "freedays":freedays,
    "exam":exam,
    "howManySubjectsPerDay":howManySubjectsPerDay
  };

}
