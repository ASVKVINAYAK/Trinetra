import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:trinetra/constants.dart';

import 'components/AttendenceCard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

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
                                  text: '${'Ayush Kejariwal'}\n',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Id: ${'1234567890'}',
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
                      'https://media.gettyimages.com/photos/portrait-of-smiling-mid-adult-man-wearing-tshirt-picture-id985138674?k=6&m=985138674&s=612x612&w=0&h=1arYWaa0TsYnwz2LyvLV5qPKCiyUufFljDjjTdI5mkQ=',
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

            /// Attendence card
            AttendenceCard(size: size),
          ],
        ),
      ),
    );
  }
}
