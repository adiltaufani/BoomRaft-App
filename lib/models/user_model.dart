class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // Fungsi untuk mengonversi dari JSON ke UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
    );
  }

  // Fungsi untuk mengonversi dari UserModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
    };
  }
}
