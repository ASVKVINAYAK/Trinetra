import 'package:flutter/material.dart';

import 'Home/HomePage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2))
        .whenComplete(() => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      body: Center(
        child: Image.network(
          'https://lh3.googleusercontent.com/tG38RRq2kEtzMsaAbzduW9kMbnpXjHuR0226snKQuDaAJd8IcCJUrEod5-hjUbGC6w=w300',
          width: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }
}
