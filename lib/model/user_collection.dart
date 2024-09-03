import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/user.dart';

class UserCollection
{
  static CollectionReference<User> getUserCollectionReference()
  {
    var database = FirebaseFirestore.instance;
    var collectionReference = database.collection(User.collectionName).withConverter(
        fromFirestore: (snapshot, options){
          Map<String, dynamic>? data = snapshot.data();
          return User.fromFirestore(data??{});
        },
        toFirestore: (user, options)=> user.toFirestore()
    );
    return collectionReference;
  }

  static Future<void> addUser(User user, String userId) async
  {
    var userCollectionReference = getUserCollectionReference();
    return userCollectionReference.doc(userId).set(user);
  }

  static Future<User?> getUser(String userid)async{
    var userCollectionReference = getUserCollectionReference();
    var snapshot = await userCollectionReference.doc(userid).get();
    return snapshot.data();
  }
  
}