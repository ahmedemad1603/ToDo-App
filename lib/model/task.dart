import 'package:cloud_firestore/cloud_firestore.dart';

class Task
{
  static const String collectionName = "Tasks";
  String? id;
  String? title;
  Timestamp? date;
  bool? isDone;

  Task({
    this.id,
    this.date,
    this.title,
    this.isDone = false
  });

  Task.fromFirestore(Map<String, dynamic>? data)
  {
    id = data?["id"];
    title = data?["title"];
    date = data?["date"];
    isDone = data?["isDone"];
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      "id": id,
      "title": title,
      "date": date,
      "isDone": isDone
    };
  }
}