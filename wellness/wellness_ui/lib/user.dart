import 'dart:convert';

class User {
  User({this.email, this.password, this.mobile, this.city, this.name});
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? city;

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      mobile: json["mobile"],
      city: json["city"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "mobile": mobile,
        "city": city
      };
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
