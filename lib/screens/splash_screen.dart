import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';
import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() => _determinePosition())
        .whenComplete(() => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false));
    super.initState();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _determinePosition() async {
    /// Permisions are auto handled
    Position _position = await Geolocator.getCurrentPosition().timeout(
      Duration(seconds: 15),
      onTimeout: () async {
        Fluttertoast.showToast(
            msg: 'Can\'t access current Location', backgroundColor: Colors.red);
        return await Geolocator.getLastKnownPosition();
      },
    );

    log('${_position.latitude}, ${_position.longitude}');
    final coordinates =
        new Coordinates(_position.latitude, _position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var firstAddress = addresses.first;
    geoAddress = firstAddress;

    // log(geoAddress.toMap().toString());
    // log("${firstAddress.featureName} : ${firstAddress.addressLine}");
    // log("${firstAddress.toString()}");

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181926),
      body: Center(
        child: Image.network(
          'https://lh3.googleusercontent.com/tG38RRq2kEtzMsaAbzduW9kMbnpXjHuR0226snKQuDaAJd8IcCJUrEod5-hjUbGC6w=w300',
          width: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }
}
