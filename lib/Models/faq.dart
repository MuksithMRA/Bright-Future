import 'dart:convert';

class FAQ {
  String title;
  String subtitle;
  Map<String, dynamic>? userData;

  FAQ({
    required this.title,
    required this.subtitle,
    required this.userData,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'subtitle': subtitle, 'userData': userData};
  }

  factory FAQ.fromMap(Map<String, dynamic> map) {
    return FAQ(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      userData: Map<String, dynamic>.from(map['userData']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FAQ.fromJson(String source) => FAQ.fromMap(json.decode(source));
}
