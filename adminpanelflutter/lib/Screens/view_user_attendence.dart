import 'dart:io';

import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:adminpanelflutter/services/Userdata.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline/flutter_timeline.dart';

import 'individual_attendence.dart';

class AttendenceUI extends StatefulWidget {
  @override
  _attendencescreen createState() => new  _attendencescreen();
}

class _attendencescreen extends State<AttendenceUI> {

  var cardtextstyle=TextStyle(fontFamily: "Montserrat Regular",fontSize: 20,color: Colors.black87,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text("View Users Attendence details"),
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          leading: IconButton(icon:Icon(Icons.arrow_back),
            //onPressed:() => Navigator.pop(context, false),
            onPressed:() => Navigator.pop(context),
          ),
      ),
      body:Center(
         child: FutureBuilder <List<UserElement>>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserElement> data = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      String d = "${data[index].employeeId}";

                        return Card(
                          color: Colors.pinkAccent,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                      ),
                          child: Center(
                            child: TimelineEventCard(
                              title: Text("${data[index].employeeId}",
                                  style: cardtextstyle,
                                textAlign: TextAlign.center,
                              ),
                              content: Card(
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70),
                                  ),
                                   color: Colors.blueAccent,
                      child:IconButton(
                                      icon: new Icon(Icons.check),
                                      iconSize: 25,
                                      onPressed:()
                                      {
                                        String x="${data[index].phone}";
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context) => indivdualdata(ph: x,)));
                                      }
                                  ),
                                ),
                      ),
                          ),
                        );



                      // return Card(
                      //   color: Colors.lightBlueAccent,
                      //   shape:RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(50),
                      //   ),
                      //   elevation: 5,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //     Align(
                      //       alignment: Alignment.topCenter,
                      //
                      //     child:IconButton(
                      //           icon: new Icon(Icons.check),
                      //           iconSize: 25,
                      //           onPressed:()
                      //           {
                      //             String x="${data[index].phone}";
                      //             Navigator.push(context, MaterialPageRoute(builder:
                      //                 (context) => indivdualdata(ph: x,)));
                      //           }
                      //       ),
                      // ),
                      //       Align(
                      //       alignment: Alignment.center,
                      // child: Text(d),
                      // ),
                      //     ],
                      //   ),
                      // );
                    },
                  );
              }
              // By default show a loading spinner.
              return  CircularProgressIndicator(
              );
            },
          ),
       ),
    );
  }
}