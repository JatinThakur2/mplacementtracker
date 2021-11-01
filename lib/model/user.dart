import 'dart:io';

class User {
  String email;

  String name;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  String role;

  User(
      {this.email = '',
      this.name = '',
      this.userID = '',
      this.profilePictureURL = '', 
      this.role=''})
      : this.appIdentifier = 'mplacemetTracker ${Platform.operatingSystem}';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        name: parsedJson['name'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        role: parsedJson['role'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'name': this.name,
      'id': this.userID,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'role':this.role
    };
  }
}
