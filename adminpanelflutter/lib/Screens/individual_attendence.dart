import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class indivdualdata extends StatefulWidget {

  String ph;
  indivdualdata({this.ph});

  @override
  _individualdata createState() => new  _individualdata();
}

class _individualdata extends State<indivdualdata> {
  @override
  Widget build(BuildContext context) {

    return new Center(

      child: FutureBuilder <List<Attendance>>(
        future: getattendence(widget.ph),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Attendance> data = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                String d = "${data[index].lat} + ${data[index].lon}  ";
                return Card(
                  color: Colors.lightBlueAccent,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: new Icon(Icons.check),
                        iconSize: 25,
                        onPressed: () {  },
                      ),
                      Text(d,
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
