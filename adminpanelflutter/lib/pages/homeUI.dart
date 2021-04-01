import 'dart:developer';
import 'package:adminpanelflutter/API_Models/user_attendance.dart';
import 'package:adminpanelflutter/Screens/individual_attendence.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:adminpanelflutter/common/base.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenUI extends StatefulWidget {
  @override
  _HomeUI createState() => _HomeUI();
}

class _HomeUI extends State<HomeScreenUI> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Dashboard",
      // appBarPinned: true,
      body: Container(
        color: Color(0xFFa8e6cf),
        // alignment: Alignment.center,
        child: FutureBuilder<UsersAttendance>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> data = snapshot.data.users;
              data.removeWhere(
                  (element) => element == null || element.fcm == null);
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  hoverThickness: 5,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    child: Scrollbar(
                      hoverThickness: 5,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showBottomBorder: true,
                          columns: [
                            DataColumn(label: Text('Avatar')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Phone')),
                            DataColumn(label: Text('Attendance')),
                            DataColumn(label: Text('Present/Total')),
                            DataColumn(label: Text('Current Logs')),
                          ],
                          rows: [
                            // for (var j = 0; j < 10; j++)
                            for (var _user in data) buildDataRow(_user),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            // By default show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  DataRow buildDataRow(User _user) {
    return DataRow(cells: [
      DataCell(
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://techspace-trinetra.herokuapp.com' + _user.photo,
          ),
          maxRadius: 25,
          minRadius: 10,
          onBackgroundImageError: (exception, stackTrace) {
            log(stackTrace.toString());
          },
        ),
      ),
      DataCell(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => indivdualdata(ph: _user.phone),
            )),
        child: Text(
          _user.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      DataCell(Text(_user.employeeId)),
      DataCell(Text(_user.phone)),
      DataCell(
        Container(
            padding: EdgeInsets.all(5),
            width: 50,
            height: 30,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (_user.overall.present ~/ _user.overall.total * 100) > 75
                    ? Colors.green[200]
                    : Colors.redAccent[100]),
            child: Text((_user.overall.present / _user.overall.total * 100)
                .toStringAsFixed(1))),
      ),
      DataCell(Text('${_user.overall.present}/${_user.overall.total}')),
      DataCell(Text(_user.current.logs
          .map((e) => e.available ? '✔' : '❌')
          .toList()
          .toString())),
    ]);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

// ignore: must_be_immutable
// class AwesomeListItem extends StatefulWidget {
//   String title;
//   String content;
//   Color color;
//   String image;
//
//   AwesomeListItem({this.title, this.content, this.color, this.image});
//
//   @override
//   _AwesomeListItemState createState() => new _AwesomeListItemState();
// }
//
// class _AwesomeListItemState extends State<AwesomeListItem> {
//   @override
//   Widget build(BuildContext context) {
//     return new Row(
//       children: <Widget>[
//         new Container(width: 10.0, height: 280.0, color: Colors.yellow),
//         new Expanded(
//           child: new Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
//             child: Container(
//               width: 10.0,
//               height: 225.0,
//               padding: EdgeInsets.all(8),
//               child: Card(
//                 color: Colors.cyanAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: new Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                       child: new Text(
//                         widget.title,
//                         style: TextStyle(
//                             color: Colors.black87,
//                             fontSize: 30.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     new Padding(
//                       padding: EdgeInsets.all(10),
//                       child: new Text(
//                         widget.content,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         new Container(
//           height: 150.0,
//           width: 150.0,
//           color: Colors.white,
//           child: Stack(
//             children: <Widget>[
//               new Transform.translate(
//                 offset: new Offset(50.0, 0.0),
//                 child: new Container(
//                   height: 100.0,
//                   width: 100.0,
//                   color: widget.color,
//                 ),
//               ),
//               new Transform.translate(
//                 offset: Offset(20.0, 20.0),
//                 child: new Card(
//                   elevation: 10.0,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.indigo[200],
//                     radius: 50,
//                     backgroundImage: NetworkImage(widget.image),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
