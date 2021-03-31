import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/intl.dart';


class indivdualdata extends StatefulWidget {

  String ph;
  indivdualdata({this.ph});

  @override
  _individualdata createState() => new  _individualdata();
}

class _individualdata extends State<indivdualdata> {

  String address="abc";
  Future<void> _determinePosition(double lat, double lon) async {
    final coordinates = new Coordinates(lat,lon);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var firstAddress = addresses.first;
    setState(() {
      address="${firstAddress.addressLine}";
    });
  }

  @override
  Widget build(BuildContext context) {
    print(address);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("View Users Attendence Details "),
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          leading: IconButton(icon:Icon(Icons.arrow_back),
            //onPressed:() => Navigator.pop(context, false),
            onPressed:() => Navigator.pop(context),
          ),
        ),
        body: Center(
        child: FutureBuilder <List<Attendance>>(
          future: getattendence(widget.ph),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Attendance> data = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  String e="${data[index].available}";
                  _determinePosition(data[index].lat,data[index].lon);
                  return Card(
                    color: Colors.lightGreenAccent,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: BubbleTimeline(
                        bubbleDiameter: 120,
                        // List of Timeline Bubble Items
                        items: [
                          TimelineItem(
                            title: address,
                            subtitle: "",
                            child:  (data[index].available)
                                ? Icon(
                              Icons.check,
                              size: 50,
                              color: Colors.green[900],
                            )
                                : Icon(
                              Icons.location_disabled,
                              size: 50,
                              color: Colors.red,
                            ),
                            bubbleColor: Colors.yellowAccent,
                          ),
                          TimelineItem(title: "sv", child: Text("bbb"), bubbleColor: Colors.pinkAccent)

                        ],
                        stripColor: Colors.teal,
                        scaffoldColor: Colors.white,
                      )

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
                  //       (data[index].available)
                  //           ? Icon(
                  //         Icons.beenhere_rounded,
                  //         color: Colors.green[900],
                  //       )
                  //           :new Icon(Icons.check),
                  //       Text(address,
                  //       ),
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
