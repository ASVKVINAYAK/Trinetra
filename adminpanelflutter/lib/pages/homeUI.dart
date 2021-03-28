import 'dart:convert';
import 'dart:math';
import 'package:adminpanelflutter/services/Userdata.dart';
import 'package:adminpanelflutter/services/apirequest.dart';
import 'package:http/http.dart' as http;
import 'package:adminpanelflutter/common/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreenUI extends StatefulWidget {
  @override
  _HomeUI createState() => _HomeUI();
}

// ignore: non_constant_identifier_names
var COLORS = [
  Color(0xFFEF7A85),
  Color(0xFFFF90B3),
  Color(0xFFFFC2E2),
  Color(0xFFB892FF),
  Color(0xFFB892FF)
];

var img=[
  'https://picsum.photos/125?random',
  'https://picsum.photos/425?random',
  'https://picsum.photos/111?random',
  'https://picsum.photos/325?random',
  'https://picsum.photos/225?random',
  'https://picsum.photos/124?random',
  'https://picsum.photos/320?random',
  'https://picsum.photos/321?random',

];

class _HomeUI extends State<HomeScreenUI> {

 @override
 void initState() {
   super.initState();
 }


  @override
  Widget build(BuildContext context) {
    userdetails u=new userdetails();
    String x=u.ud;
    String y=u.uid;
   return BaseScreen(
      title: "Dashboard",
      body: Container(
        child: new Stack(
          children: <Widget>[
            new Transform.translate(
              offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  return new ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index) {
                      DocumentSnapshot fdata=snapshot.data.docs[index];
                      String d="";
                      d=" Name: "+fdata['name']+"\n Phone no: ${fdata['phone no']}"+"\n IMEI: "+fdata['IMEI']+"\n";
                          return AwesomeListItem(
                            title: fdata.id,
                            content: d,
                            color: COLORS[new Random().nextInt(5)],
                            image: img[new Random().nextInt(4)],
                          );
                    },
                  );
                }
              ),
            ),

            new Transform.translate(
              offset: Offset(0.0, -56.0),
              child: new Container(
                child: new ClipPath(
                  clipper: new MyClipper(),
                    child: Image.network(
                      "https://raw.githubusercontent.com/ASVKVINAYAK/HC-QS/main/WhatsApp%20Image%202021-03-21%20at%207.19.14%20PM.jpeg",
                      fit: BoxFit.contain,
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.title, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 280.0, color: Colors.yellow),
        new Expanded(
          child: new Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Container(
                 width: 10.0, height: 225.0,
              padding: EdgeInsets.all(8),
              child: Card(
                color: Colors.cyanAccent,
                shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40),
                    ),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(20),
                      child: new Text(
                        widget.content,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(20.0, 20.0),
                child: new Card(
                  elevation: 10.0,
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.network(
                          widget.image,
                      ),
                    ),

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
