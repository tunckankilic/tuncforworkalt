import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    required this.skills,
    required this.updatedAt,
    required this.location,
    required this.phone,
    required this.profile,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json['_id'] ?? '',
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        isAdmin: json['isAdmin'] ?? false,
        isAgent: json['isAgent'] ?? false,
        skills: List<String>.from(json['skills'] ?? []),
        updatedAt: _parseTimestamp(json['updatedAt']),
        location: json['location'] ?? '',
        phone: json['phone'] ?? '',
        profile: json['profile'] ?? '',
      );

  final String id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final List<String> skills;
  final DateTime updatedAt;
  final String location;
  final String phone;
  final String profile;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'isAdmin': isAdmin,
        'isAgent': isAgent,
        'skills': skills,
        'updatedAt': updatedAt.toIso8601String(),
        'location': location,
        'phone': phone,
        'profile': profile,
      };

  static DateTime _parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }
}
