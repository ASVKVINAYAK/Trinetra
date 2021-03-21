import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trinetra/models/day_attendance.dart';
import 'package:trinetra/widgets/GroupedList.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Your Attendance History'),
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor),
      body: FutureBuilder<List<DayAttendence>>(
          future:
              Future.value(data.map((e) => DayAttendence.fromMap(e)).toList()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            List<Attendence> _elements = [];
            for (var item in snapshot.data) {
              _elements.addAll(item.attendence);
            }
            return GroupedListView<Attendence, DateTime>(
              elements: _elements,
              itemBuilder: (context, element) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    elevation: 8.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Icon(Icons.person),
                      title: Text(element.lat + ',' + element.lon),
                      trailing: Text(DateFormat.Hm().format(element.timestamp)),
                    ),
                  ),
                );
              },
              order: GroupedListOrder.DESC,
              // reverse: true,
              floatingHeader: true,
              useStickyGroupSeparators: true,
              groupBy: (Attendence element) => DateTime(element.timestamp.year,
                  element.timestamp.month, element.timestamp.day),
              groupHeaderBuilder: (Attendence element) => Container(
                height: 40,
                child: Align(
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${DateFormat.yMMMd().format(element.timestamp)}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ), // optional
            );
          }),
    );
  }
}

var data = [
  {
    "dateTime": "2020-12-02T18:38:04.074Z",
    "attendence": [
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
      }
    ],
    "success": true,
  },
  {
    "dateTime": "2020-12-03T18:38:04.074Z",
    "attendence": [
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
    ],
    "success": false,
  }
];
