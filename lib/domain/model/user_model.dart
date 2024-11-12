class User {
  final String id;
  final String name;
  final String email;
  final String telepon;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.telepon
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telepon: json['nomor_hp'],
    );
  }

  //  Function
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'telepon': telepon,
    };
  }
}
