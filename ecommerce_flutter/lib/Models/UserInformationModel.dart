class UserInformationModel {
  String id;
  String username;
  String email;
  DateTime createdAt;

  UserInformationModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  // Factory method to create UserModel from JSON
  factory UserInformationModel.fromJson(Map<String, dynamic> json) {
    return UserInformationModel(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  // Method to convert UserModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "username": username,
      "email": email,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
