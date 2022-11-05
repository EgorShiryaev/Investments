class User {
  final String uuid;
  // final String fullname;

  User({
    required this.uuid,
    // required this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['userUuid'],
      // fullname: json['fullname'],
    );
  }
}
