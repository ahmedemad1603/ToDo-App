import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/user.dart';

class FirestoreHelper
{
  static CollectionReference<User> getUserCollection()
  {
    var reference = FirebaseFirestore.instance.collection("User").withConverter(
        fromFirestore: (snapshot, options){
          Map<String, dynamic>? data = snapshot.data();
          return User.fromFirestore(data??{});
        },
        toFirestore: (user, options) {
          return user.toFirestore();
        }
    );
    return reference;
  }

  static Future<void> addUser(String email, String fullname, String userId) async
  {
    var document = getUserCollection().doc(userId);
    await document.set(
      User(
          id: userId,
          email: email,
          fullname: fullname)
    );
  }

  static Future<User?> getUser(String userId) async
  {
    var document = getUserCollection().doc(userId);
    var snapshot = await document.get();
    User? user = snapshot.data();
    return user;
  }
  
}