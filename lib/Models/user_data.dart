import 'dart:convert';

class UserData {
  String fullName;
  String city;
  String email;
  String phoneNumber;
  String uid;
  String photoUrl;

  get getFullName => fullName;

  set setFullName(fullName) => this.fullName = fullName;

  get getCity => city;

  set setCity(city) => this.city = city;

  get getEmail => email;

  set setEmail(email) => this.email = email;

  get getPhoneNumber => phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;

  get getUid => uid;

  set setUid(uid) => this.uid = uid;

  UserData({
    required this.fullName,
    required this.city,
    required this.email,
    required this.phoneNumber,
    required this.uid,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'city': city,
      'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'photoUrl': photoUrl
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      fullName: map['fullName'] ?? '',
      city: map['city'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));
}
