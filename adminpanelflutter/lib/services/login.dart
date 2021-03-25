import 'dart:convert';

import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class LoginUI extends StatefulWidget {
  @override
  _logUI createState() => _logUI();
}

// ignore: camel_case_types
class _logUI extends State<LoginUI> {

  TextEditingController phone = TextEditingController();
  TextEditingController imei = TextEditingController();

  bool isloading=false;
  login(String p,String i)
  async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    Map body={"phone":p, "imei":i};
    var url=Uri.parse('http://213.188.253.139:5001/login');
    var jsonresponse;
    var res=await http.post(url,body: body);
    if(res.statusCode==200)
      {
        jsonresponse=json.decode(res.body);
        print("abc");
        print("Res Code $res.statusCode   ");
        print("Res Code ($res.body)   ");
        if(jsonresponse !=null)
          {
            setState(() {
              isloading=false;
            });
            sharedPreferences.setString("token",jsonresponse['token']);
            HomeScreenUI();
          }
        else
          {
            setState(() {
                 isloading=false;
                 print("Res Code ($res.body)   ");
            });
          }

      }
  }


 getData() async {
    print("xyz");

   // Map body={"phone":"9090999999",
   //   "imei":"12345"};
   // var url=Uri.parse('http://213.188.253.139:5001/login');
   // var res=await http.post(url,body: body);
   // print('Response status: ${res.statusCode}');
   // print('Response body: ${res.body}');


    Map body={"phone":"9090999999", "imei":"12345"};
   var url=Uri.http('213.188.253.139:5001','/login',{"phone":"9090999999", "imei":"12345"});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var token = jsonResponse['token'];
      print('Token is : $token.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    }

  @override
  Widget build(BuildContext context)
  {
    getData();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Login'),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 400,
                width: 200,
                child: Column(
                  children: <Widget>[
                  TextFormField(
                  controller: phone,
                  decoration: InputDecoration(labelText: ' Enter Phone no'),
                ),
                TextFormField(
                  controller: imei,
                  decoration: InputDecoration(labelText: 'Enter IMEI'),
                ),
                SizedBox(
                  height: 80,
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed:() {
                      String p=phone.text;
                      String i=imei.text;
                      login(p, i);
                    },
                  ),
                ) ,
                ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




}


