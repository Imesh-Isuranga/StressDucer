import 'package:cloud_firestore/cloud_firestore.dart';

class AddedTasks {
  AddedTasks({
    required this.list,
  });

  final List<String?> list;

  factory AddedTasks.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AddedTasks(
      list: List<String?>.from(snapshot['list'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "list": list,
    };
  }
}
