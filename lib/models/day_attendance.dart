// To parse this JSON data, do
//
//     final dayAttendence = dayAttendenceFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DayAttendence {
  DayAttendence({
    @required this.attendence,
    @required this.status,
  });

  final List<Attendence> attendence;
  final bool status;

  factory DayAttendence.fromJson(String str) =>
      DayAttendence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DayAttendence.fromMap(Map<String, dynamic> json) => DayAttendence(
        attendence: List<Attendence>.from(
            json["attendence"].map((x) => Attendence.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "attendence": List<dynamic>.from(attendence.map((x) => x.toMap())),
        "status": status,
      };
}

class Attendence {
  Attendence({
    @required this.lat,
    @required this.lon,
    @required this.timestamp,
    @required this.available,
  });

  final double lat;
  final double lon;
  final DateTime timestamp;
  final bool available;

  factory Attendence.fromJson(String str) =>
      Attendence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendence.fromMap(Map<String, dynamic> json) => Attendence(
        lat: double.parse(json["lat"]),
        lon: double.parse(json["lon"]),
        timestamp: DateTime.parse(json["timestamp"]),
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat.toString(),
        "lon": lon.toString(),
        "timestamp": timestamp.toIso8601String(),
        "available": available,
      };
}
