class User
{
  static const String collectionName = "User";
  String? id;
  String? fullname;
  String? email;

  User({required this.id, required this.email, required this.fullname});

  User.fromFirestore(Map<String, dynamic> data)
  {
    id = data["data"];
    email = data["email"];
    fullname = data["fullname"];
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      "id": id,
      "email": email,
      "fullname": fullname
    };
  }
}