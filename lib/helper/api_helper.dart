import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trinetra/models/day_attendance.dart';
import 'package:trinetra/models/login_response.dart';
import 'package:trinetra/models/profile_model.dart';

class ApiHelper {
  final String baseUrl = 'https://techspace-trinetra.herokuapp.com/';
  String token = '';

  /// Get Request using authorization token
  Future<http.Response> _getApiData(
    String apiUrl,
  ) async {
    Map<String, String> _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${this.token}'
    };
    log(Uri.parse(baseUrl + apiUrl).toString());
    Uri _url = Uri.parse(baseUrl + apiUrl);
    return await http.get(_url, headers: _headers);
  }

  /// Post Request using authorization token
  Future<http.Response> _postApiData(
      String apiUrl, Map<String, dynamic> parameters) async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${this.token}'
    };
    log(Uri.parse(baseUrl + apiUrl).toString());
    log(parameters.toString());
    Uri _url = Uri.parse(baseUrl + apiUrl);
    return await http.post(_url,
        body: jsonEncode(parameters), headers: _headers);
  }

  /// Login API
  Future<LoginResponse> login({int phone, String imei}) async {
    final String apiUrl = 'login';
    Map<String, String> data = {
      "phone": phone?.toString() ?? "9090999999",
      "imei": imei ?? "12345"
    };

    try {
      http.Response response = await _postApiData(apiUrl, data);
      // log(response.toString());
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        log(response.body);
        LoginResponse lr = LoginResponse.fromJson(response.body);
        this.token = lr.token;
        return lr;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Get Profile API
  Future<ProfileModel> getProfile() async {
    final String apiUrl = 'profile';
    try {
      http.Response response = await _getApiData(apiUrl);
      log(response.statusCode.toString());
      if (response.statusCode != 200 || response.body == null) {
        return null;
      } else {
        log(response.body);
        ProfileModel pm = ProfileModel.fromJson(response.body);
        return pm;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Get Attendence API
  Future getAttendence(int phone) async {
    final String apiUrl = 'user/$phone';
    try {
      http.Response response = await _getApiData(apiUrl);
      if (response.statusCode == 200 || response.body != null) {
        return null;
      } else {
        log(response.body);
        DayAttendence attendence = DayAttendence.fromJson(response.body);
        return attendence;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Set IMEI no.
  Future setIMEI() async {
    final String apiUrl = 'login';
  }

  /// Save Location
  Future saveLocation() async {
    final String apiUrl = 'login';
  }

  /// Get Profile image
  Future getProfileImage() async {
    final String apiUrl = 'login';
  }
}
