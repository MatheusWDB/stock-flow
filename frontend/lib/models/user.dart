class User {
  User({
    required this.username,
    this.name,
    this.userId,
    this.password,
    this.token,
  });

  final int? userId;
  final String username;
  final String? password;
  final String? name;
  final String? token;

  static User? currentUser;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        name: json['name'],
        username: json['username'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'name': name,
      };
}
