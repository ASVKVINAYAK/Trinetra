import 'package:adminpanelflutter/API_Models/user_attendence_data.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';


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
      address="${firstAddress}";
    });
  }

  @override
  Widget build(BuildContext context) {
    print(address);
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
                String e="${data[index].available}";
                _determinePosition(data[index].lat,data[index].lon);
                return Card(
                  color: Colors.lightBlueAccent,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (data[index].available)
                          ? Icon(
                        Icons.beenhere_rounded,
                        color: Colors.green[900],
                      )
                          :new Icon(Icons.check),
                      Text(address,
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
