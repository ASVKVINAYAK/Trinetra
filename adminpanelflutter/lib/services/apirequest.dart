import 'dart:convert';
import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/Userdata.dart';
import 'package:http/http.dart' as http;

Future<List<UserElement>>  getData() async {
    print("xyz");
    Map body = {"username": "admin",
      "password": "admin123"};
    var url = Uri.parse('https://techspace-trinetra.herokuapp.com/login');
    Map<String, String> headtoken = {
      'Content-type': 'application/json; charset=UTF-8',
    };
    var restoken = await http.post(
        url, body: jsonEncode(body), headers: headtoken);
    print('Response status: ${restoken.statusCode}');
    var admindata = jsonDecode(restoken.body);
    String token = admindata['token'];
    print(token);

    Map<String, String> headuser = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var urluser = Uri.parse('https://techspace-trinetra.herokuapp.com/user');
    var resuser = await http.get(urluser, headers: headuser);
    print(resuser.body);
    final u = userFromJson(resuser.body);
    List d=u.users;
    return d;
  }




Future<List<Attendance>>  getattendence(String x) async {
  print("xyz");
  Map body = {"username": "admin",
    "password": "admin123"};
  var url = Uri.parse('https://techspace-trinetra.herokuapp.com/login');
  Map<String, String> headtoken = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  var restoken = await http.post(
      url, body: jsonEncode(body), headers: headtoken);
  var admindata = jsonDecode(restoken.body);
  String token = admindata['token'];

  Map<String, String> headuser = {
    'Content-type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var urluser = Uri.parse('https://techspace-trinetra.herokuapp.com/user/$x');
  var resuser = await http.get(urluser, headers: headuser);
  final u = userattendenceFromJson(resuser.body);
  List d=u.attendance;
  return d;
}
























