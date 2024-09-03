import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/model/user_collection.dart';

class TaskCollection
{
  static CollectionReference<Task> getTaskCollection(String userId)
  {
    var userCollection = UserCollection.getUserCollectionReference();
    var userDoc = userCollection.doc(userId);
    var taskCollection = userDoc.collection(Task.collectionName).withConverter(
        fromFirestore: (snapshot, options) {
          return Task.fromFirestore(snapshot.data());
        },
        toFirestore: (task, options) => task.toFirestore()
    );
    return taskCollection;
  }

  static Future<void> createTask(Task newTask, String userId) async
  {
    var collectionRef = getTaskCollection(userId);
    var docRef = collectionRef.doc();
    newTask.id = docRef.id;
    await docRef.set(newTask);
  }
}
