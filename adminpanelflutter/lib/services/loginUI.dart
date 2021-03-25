import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController phone = TextEditingController();
  TextEditingController imei = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: SizedBox(
        child: Image.network(
          "https://raw.githubusercontent.com/ASVKVINAYAK/HC-QS/main/WhatsApp%20Image%202021-03-21%20at%207.19.14%20PM.jpeg",
          fit: BoxFit.fill,
        ),
      ),
    );

    final email = TextFormField(
      autofocus: false,
      controller: phone,
      decoration: InputDecoration(
        hintText: ' Enter Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextFormField(
      autofocus: false,
      controller: imei,
        obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          String p=phone.text;
          String i=imei.text;
          print(p);
          print(i);
          if(p=="9090999999" && i=="12345")
            {
              Fluttertoast.showToast(
                  msg: "Welcome Back",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.greenAccent,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenUI()));
            }
          else
            {
              showDialog(
                context: context,
                builder: (context)
              {
                return AlertDialog(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.red,
                  title: Text('Incorrect Login details',style: TextStyle(color: Colors.black87)),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Try Again',style: TextStyle(color: Colors.yellowAccent)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
              );

          }
        },
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}