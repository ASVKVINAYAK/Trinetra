import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen2 extends StatelessWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;

  LoginScreen2({Key k, this.backgroundColor1, this.backgroundColor2, this.highlightColor, this.foregroundColor});
  TextEditingController phone = TextEditingController();
  TextEditingController imei = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.centerLeft,
            end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
            colors: [this.backgroundColor1, this.backgroundColor2], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
              child: Center(
                child: new Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 128.0,
                      child: new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: this.foregroundColor,
                        radius: 100.0,
                        child: Image.network("https://raw.githubusercontent.com/ASVKVINAYAK/Trinetra/admin-panel/images/trinatra%20logo.jpeg",
                          height: 300,),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: this.foregroundColor,
                          width: 1.0,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Text(
                        "Trinatra Admin Panel",
                        style: TextStyle(color: this.foregroundColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: this.foregroundColor,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                    padding:
                    EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                    child: Icon(
                      Icons.alternate_email,
                      color: this.foregroundColor,
                    ),
                  ),
                  new Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter email',
                        hintStyle: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: this.foregroundColor,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                    padding:
                    EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                    child: Icon(
                      Icons.lock_open,
                      color: this.foregroundColor,
                    ),
                  ),
                  new Expanded(
                    child: TextField(
                      controller: imei,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter password',
                        hintStyle: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
              alignment: Alignment.center,
              color: Colors.pinkAccent,
              child: new Row(
                children: <Widget>[
                  new SizedBox(
                    width:  MediaQuery.of(context).size.width-80,
                    height: 40,
                    child: new TextButton(
                      onPressed: () {
                        String p=phone.text;
                        String i=imei.text;
                        print(p);
                        print(i);
                        if(p=="admin" && i=="admin123")
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
                      child: Text(
                        "Log In",
                        style: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new SizedBox(
                    width:  MediaQuery.of(context).size.width-100,
                    height: 100,
                    child: new FlatButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      color: Colors.transparent,
                      onPressed: () => {},
                      child: Text(
                        "Don't have an account? Create One",
                        style: TextStyle(color: this.foregroundColor.withOpacity(0.5)),
                      ),
                    ),
                  ),
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
