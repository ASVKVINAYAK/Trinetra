import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trinetra/constants.dart';
import 'package:trinetra/models/profile_model.dart';

import 'components/AttendanceCard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key, this.userProfile}) : super(key: key);
  final ProfileModel userProfile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            /// Header Name id and photo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText.rich(
                            TextSpan(
                              text: 'Hello 👋,\n',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white.withOpacity(0.9)),
                              children: [
                                TextSpan(
                                  text: '${userProfile.name}\n',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Id: ${userProfile.employeeId}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white60),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.start,
                            wrapWords: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.indigo[200],
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://techspace-trinetra.herokuapp.com/${userProfile.photo}',
                    ),
                  ),
                ],
              ),
            ),

            /// Location
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListTile(
                  enabled: true,
                  // tileColor: Theme.of(context).cardColor,
                  trailing: Icon(Icons.location_on),
                  title: AutoSizeText('Your Current Location'),
                  subtitle: AutoSizeText(geoAddress.addressLine),
                ),
              ),
            ),

            /// Attendance card
            AttendanceCard(size: size, userProfile: userProfile),

            /// Current Attendance
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(16),
              ),
              width: size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Today\'s Attendance',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var att in userProfile.current.logs)
                          Column(
                            children: [
                              (att.available)
                                  ? Icon(
                                      Icons.beenhere_rounded,
                                      color: Colors.green[900],
                                    )
                                  : Icon(
                                      Icons.unpublished_outlined,
                                      color: Colors.red[900],
                                    ),
                              AutoSizeText(
                                DateFormat.jm().format(att.timestamp),
                                style: TextStyle(color: Colors.blueGrey[800]),
                              ),
                            ],
                          ),
                        // Icon(
                        //   Icons.beenhere_rounded,
                        //   color: Colors.green[900],
                        // ),
                        // Icon(
                        //   Icons.beenhere_outlined,
                        //   color: Colors.blueGrey,
                        // ),
                        // Icon(
                        //   Icons.beenhere_outlined,
                        //   color: Colors.blueGrey,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
