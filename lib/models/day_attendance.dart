// To parse this JSON data, do
//
//     final dayAttendence = dayAttendenceFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DayAttendence {
  DayAttendence(
      {@required this.dateTime,
      @required this.attendence,
      @required this.success});

  final DateTime dateTime;
  final List<Attendence> attendence;
  final bool success;

  factory DayAttendence.fromJson(String str) =>
      DayAttendence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DayAttendence.fromMap(Map<String, dynamic> json) => DayAttendence(
      dateTime: DateTime.parse(json["dateTime"]),
      attendence: List<Attendence>.from(
          json["attendence"].map((x) => Attendence.fromMap(x))),
      success: json['success']);

  Map<String, dynamic> toMap() => {
        "dateTime": dateTime.toIso8601String(),
        "attendence": List<dynamic>.from(attendence.map((x) => x.toMap())),
        "success": success,
      };
}

class Attendence {
  Attendence({
    @required this.lat,
    @required this.lon,
    @required this.timestamp,
  });

  final String lat;
  final String lon;
  final DateTime timestamp;

  factory Attendence.fromJson(String str) =>
      Attendence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendence.fromMap(Map<String, dynamic> json) => Attendence(
        lat: json["lat"],
        lon: json["lon"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
        "timestamp": timestamp.toIso8601String(),
      };
}
