import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/pages/homeUI.dart';
import 'package:adminpanelflutter/services/Userdata.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'individual_attendence.dart';

class AttendenceUI extends StatefulWidget {
  @override
  _attendencescreen createState() => new  _attendencescreen();
}

class _attendencescreen extends State<AttendenceUI> {
  @override
  Widget build(BuildContext context) {
    return new Center(

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
                      color: Colors.lightBlueAccent,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,

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
                          Align(
                          alignment: Alignment.center,
                    child: Text(d),
                    ),
                        ],
                      ),
                    );
                  },
                );
            }
            // By default show a loading spinner.
            return  CircularProgressIndicator(
            );
          },
        ),
    );
  }
}