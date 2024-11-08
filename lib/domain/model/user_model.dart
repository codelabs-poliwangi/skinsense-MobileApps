class User {
  final String id;
  final String email;
  final String telepon;

  const User({
    required this.id,
    required this.email,
    required this.telepon
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      telepon: json['nomor_hp'],
    );
  }

  //  Function
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'telepon': telepon,
    };
  }
}
