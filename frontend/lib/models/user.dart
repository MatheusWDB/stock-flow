class User {
  User({
    required this.email,
    this.name,
    this.username,
    this.userId,
    this.password,
  });

  final int? userId;
  final String? username;
  final String? password;
  final String email;
  final String? name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'name': name,
      };
}
