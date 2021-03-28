import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:trinetra/helper/api_helper.dart';
import 'package:trinetra/models/day_attendance.dart';
import 'package:trinetra/widgets/GroupedList.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiHelper _apihelper = new ApiHelper();
    var listviewController = new ScrollController();
    return Scaffold(
      appBar: AppBar(
          title: Text('Your Attendance History'),
          centerTitle: true,
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.refresh,
            //       color: Colors.white,
            //     ))
          ],
          backgroundColor: Theme.of(context).backgroundColor),
      body: FutureBuilder<DayAttendance>(
          future: _apihelper.getAttendance(9090999999).then((value) => value),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              ));
            return Scrollbar(
              controller: listviewController,
              interactive: true,
              thickness: 5,
              child: GroupedListView<Attendance, DateTime>(
                controller: listviewController,
                elements: snapshot.data.attendance,
                itemBuilder: (context, element) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 5.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(Icons.person),
                        title: FutureBuilder<Address>(
                          future: Geocoder.local
                              .findAddressesFromCoordinates(
                                  Coordinates(element.lat, element.lon))
                              .then((value) => value.first),
                          builder: (BuildContext context,
                              AsyncSnapshot<Address> snapshot) {
                            if (!snapshot.hasData)
                              return Text('Loading Location...');
                            return AutoSizeText(snapshot.data.addressLine);
                          },
                        ),
                        trailing:
                            Text(DateFormat.jm().format(element.timestamp)),
                      ),
                    ),
                  );
                },
                order: GroupedListOrder.DESC,
                // reverse: true,
                floatingHeader: true,
                useStickyGroupSeparators: true,
                groupBy: (Attendance element) => DateTime(
                    element.timestamp.year,
                    element.timestamp.month,
                    element.timestamp.day),
                groupHeaderBuilder: (Attendance element) => Container(
                  height: 40,
                  width: 120,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Text(
                    '${DateFormat.yMMMd().format(element.timestamp)}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

var data = {
  "attendance": [
    {
      "lat": "72.8241",
      "lon": "-23.0402",
      "timestamp": "2020-12-02T18:38:04.074Z"
    },
    {
      "lat": "-79.7314",
      "lon": "163.2158",
      "timestamp": "2020-12-02T11:26:39.437Z"
    },
    {
      "lat": "-74.9293",
      "lon": "-61.4999",
      "timestamp": "2020-12-02T01:07:51.219Z"
    },
    {
      "lat": "72.8241",
      "lon": "-23.0402",
      "timestamp": "2020-12-03T05:15:32.954Z"
    },
    {
      "lat": "-79.7314",
      "lon": "163.2158",
      "timestamp": "2020-12-03T11:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-04T11:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-04T13:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-04T11:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-05T15:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-05T15:26:39.437Z"
    },
    {
      "lat": "-79.7324",
      "lon": "163.2153",
      "timestamp": "2020-12-05T15:26:39.437Z"
    },
  ],
  "success": false,
};
